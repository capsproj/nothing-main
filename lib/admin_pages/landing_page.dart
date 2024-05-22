import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minmalecommerce/admin_pages/admin_components/admin_drawer.dart';
import 'package:minmalecommerce/components/button.dart';
import 'package:minmalecommerce/pages/cart_page.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController itemName = TextEditingController();
  final TextEditingController itemDescription = TextEditingController();
  final TextEditingController itemPrice = TextEditingController();
  final TextEditingController itemQty = TextEditingController();
  File? _image;
  bool _isLoading = false;

  static String id = '/Landing_page';

  Future<void> _addProduct() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Upload image to Firebase Storage
      final imageFile = _image;
      if (imageFile == null) {
        print('Please pick an image first');
        return;
      }

      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('product_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = storageRef.putFile(imageFile);
      await uploadTask.whenComplete(() => null);

      final imageUrl = await storageRef.getDownloadURL();

      // Save product data to Firestore
      final collection =
          FirebaseFirestore.instance.collection('added_products');
      final data = {
        'name': itemName.text,
        'description': itemDescription.text,
        'price': double.tryParse(itemPrice.text) ?? 0.0,
        'quantity': int.tryParse(itemQty.text) ?? 0,
        'imageUrl': imageUrl,
      };

      await collection.add(data);

      itemName.clear();
      itemDescription.clear();
      itemPrice.clear();
      itemQty.clear();
      _image = null;

      print('Product added successfully!');
    } catch (e) {
      print('Error adding product: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        actions: [],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: AdminDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Add a New Product",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StyleButton(
                onTap: () async {
                  final pickedFile =
                      await _imagePicker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                },
                text: 'Upload Image',
              ),
              const SizedBox(
                height: 10,
              ),
              // Image Preview
              _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[200], // Placeholder color
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),

              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: itemName,
                decoration: InputDecoration(labelText: 'Item Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: itemDescription,
                decoration: InputDecoration(labelText: 'Item Description'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: itemPrice,
                decoration: InputDecoration(labelText: 'Item Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: itemQty,
                decoration: InputDecoration(labelText: 'Item Quantity'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : StyleButton(
                      onTap: _addProduct,
                      text: 'Add Product',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
