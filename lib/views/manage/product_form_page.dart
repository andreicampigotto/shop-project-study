// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description!;
        _formData['imageUrl'] = product.imageUrl!;

        _imageUrlController.text = product.imageUrl!;
      }
    }
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<ProductList>(
        context,
        listen: false,
      ).saveProduct(_formData);
      Navigator.of(context).pop();
    } catch (onError) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error has occurred'),
          content: Text(onError.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(onError),
              child: const Text('Okay'),
            )
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return isValidUrl && endsWithFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Form'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.all(8),
              height: 550,
              child: Card(
                margin: const EdgeInsets.only(top: 16),
                elevation: 8,
                semanticContainer: true,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          TextFormField(
                            initialValue: (_formData['name'] ?? '') as String,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_priceFocus);
                            },
                            textInputAction: TextInputAction.next,
                            onSaved: (name) => _formData['name'] = name ?? '',
                            validator: ($name) {
                              final name = $name ?? '';
                              if (name.trim().isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            initialValue: _formData['price']?.toString(),
                            decoration:
                                const InputDecoration(labelText: 'Price'),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            focusNode: _priceFocus,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_descriptionFocus);
                            },
                            onSaved: (price) =>
                                _formData['price'] = double.parse(price ?? '0'),
                            validator: ($price) {
                              final priceString = $price ?? '';
                              final price = double.tryParse(priceString) ?? -1;
                              if (price <= 0) {
                                return 'Price is required';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            initialValue: _formData['description']?.toString(),
                            decoration:
                                const InputDecoration(labelText: 'Description'),
                            focusNode: _descriptionFocus,
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            onSaved: (description) =>
                                _formData['description'] = description ?? '',
                            validator: ($description) {
                              final description = $description ?? '';
                              if (description.trim().isEmpty) {
                                return 'Description is required';
                              }
                              return null;
                            },
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Image URL'),
                                  focusNode: _imageUrlFocus,
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.done,
                                  controller: _imageUrlController,
                                  onFieldSubmitted: (_) => _submitForm,
                                  onSaved: (imageUrl) =>
                                      _formData['imageUrl'] = imageUrl ?? '',
                                  validator: ($url) {
                                    final url = $url ?? '';

                                    isValidImageUrl(url);

                                    if (!isValidImageUrl(url)) {
                                      return 'URL is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8, left: 8),
                                height: 108,
                                width: 108,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).hintColor,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: _imageUrlController.text.isEmpty
                                    ? const Text(
                                        'Input image URL',
                                        style: TextStyle(fontSize: 12),
                                      )
                                    : FittedBox(
                                        fit: BoxFit.cover,
                                        child: Image.network(
                                            _imageUrlController.text),
                                      ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(
                                top: 16, start: 16, end: 16, bottom: 8),
                            child: FilledButton(
                              onPressed: _submitForm,
                              child: const Text('Save'),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
    );
  }
}
