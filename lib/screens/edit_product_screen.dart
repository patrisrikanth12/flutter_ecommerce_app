import 'package:ecommerce_app/provider/product.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImage);
    super.initState();
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
    _formKey.currentState!.save();
    print("saved");
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
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _tempProduct = Product(
                    id: _tempProduct.id,
                    title: _tempProduct.description,
                    description: value!,
                    price: _tempProduct.price,
                    imageUrl: _tempProduct.imageUrl,
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
