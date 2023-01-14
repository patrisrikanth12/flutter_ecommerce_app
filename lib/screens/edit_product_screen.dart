import 'package:ecommerce_app/provider/product.dart';
import 'package:ecommerce_app/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit-product-scrreen';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  Product _tempProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  final _formKey = GlobalKey<FormState>();
  bool _init = true;
  Map _initValues = {
    'title': '',
    'description': '',
    'price': '',
  };

  // cannot use context inside init state
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      final arguments = ModalRoute.of(context)!.settings.arguments;
      if (arguments != null) {
        String id = arguments as String;
        _tempProduct =
            Provider.of<ProductsProvider>(context).getProductbyId(id);
        _initValues = {
          'title': _tempProduct.title,
          'description': _tempProduct.description,
          'price': _tempProduct.price.toString(),
        };
        // since we are using controller,
        // inside TextFormField we cannot use initialValue property
        _imageUrlController.text = _tempProduct.imageUrl;
      }
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImage);
    super.dispose();
  }

  void _updateImage() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // if ID is not present, add the product, otherwise update the product
      if (_tempProduct.id.isEmpty) {
        Provider.of<ProductsProvider>(context, listen: false)
            .addItem(_tempProduct);
      } else {
        Provider.of<ProductsProvider>(context, listen: false)
            .updateItem(_tempProduct.id, _tempProduct);
        
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          TextButton(
            onPressed: _saveForm,
            child: const Text("Save", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: const InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _tempProduct = Product(
                    id: _tempProduct.id,
                    title: value!,
                    description: _tempProduct.description,
                    price: _tempProduct.price,
                    imageUrl: _tempProduct.imageUrl,
                    isFavourite: _tempProduct.isFavourite,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "The field should not be empty";
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _tempProduct = Product(
                    id: _tempProduct.id,
                    title: _tempProduct.title,
                    description: _tempProduct.description,
                    price: double.tryParse(value!) ?? 0,
                    imageUrl: _tempProduct.imageUrl,
                    isFavourite: _tempProduct.isFavourite,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "The field should not be empty";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a number";
                  }
                  if (double.parse(value) <= 0) {
                    return "The price should be greater than zero";
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _tempProduct = Product(
                    id: _tempProduct.id,
                    title: _tempProduct.title,
                    description: value!,
                    price: _tempProduct.price,
                    imageUrl: _tempProduct.imageUrl,
                    isFavourite: _tempProduct.isFavourite,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "The field should not be empty";
                  }
                  if (value.length < 10) {
                    return "The description should atleast have 10 characters";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Container(
                    width: 70.0,
                    height: 70.0,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0),
                    ),
                    child: FittedBox(
                      child: _imageUrlController.text.isNotEmpty
                          ? Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            )
                          : const Text("Enter Image URL"),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: "Image URL"),
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onSaved: (value) {
                        _tempProduct = Product(
                          id: _tempProduct.id,
                          title: _tempProduct.title,
                          description: _tempProduct.description,
                          price: _tempProduct.price,
                          imageUrl: value!,
                          isFavourite: _tempProduct.isFavourite,
                        );
                      },
                      validator: (value) {
                        if (!value!.startsWith("http") &&
                            !value.startsWith("https")) {
                          return "Invalid Url";
                        }
                        if (!value.endsWith(".jpg") &&
                            !value.endsWith(".png") &&
                            !value.endsWith(".jpeg")) {
                          return "Invalid Url";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
