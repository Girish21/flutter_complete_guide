import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/product_detail_argument.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../providers/product.dart';
import '../providers/products.dart';

final uuid = Uuid();

class EditProduct extends StatefulWidget {
  static const RouteName = '/edit-product';

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var _editedProduct = Product(
    id: uuid.v4(),
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );

  var isInit = true;
  var newProduct = true;

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      final productId =
          ModalRoute.of(context).settings.arguments as ProductDetailArgument;

      if (productId != null) {
        _editedProduct = Provider.of<Products>(context).findById(productId.id);
        _imageUrlController.text = _editedProduct.imageUrl;
        newProduct = false;
      }
    }
    isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }

  void updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.length != 0 &&
          _imageUrlController.text.startsWith('https')) setState(() {});
    }
  }

  void _saveForm() async {
    var isSuccess = false;
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      if (newProduct) {
        isSuccess = await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } else {
        Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct);
      }
      if (isSuccess) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Product',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(
                    _priceFocusNode,
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Title is required';
                    return null;
                  },
                  initialValue: _editedProduct.title,
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: value,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite: _editedProduct.isFavorite,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(
                    _descriptionFocusNode,
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter price';
                    if (double.tryParse(value) == null)
                      return 'Please enter a valid price';

                    if (double.parse(value) <= 0)
                      return 'Please enter a number greater than 0';

                    return null;
                  },
                  initialValue: _editedProduct.price.toStringAsFixed(2),
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(value),
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite: _editedProduct.isFavorite,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter a description';
                    return null;
                  },
                  initialValue: _editedProduct.description,
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: value,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite: _editedProduct.isFavorite,
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(
                        top: 8,
                        right: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text(
                              'Enter a URL',
                            )
                          : FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(
                                _imageUrlController.text,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) => _saveForm(),
                        validator: (value) {
                          if (value.isEmpty) return 'Please enter an image URL';
                          if (!value.startsWith('https'))
                            return 'Please enter a valid image URL';

                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: value,
                            isFavorite: _editedProduct.isFavorite,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
