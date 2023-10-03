import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:widget_test/providers/city_provider.dart';

class ActivityFormImagePicker extends StatefulWidget {
  const ActivityFormImagePicker({super.key, required this.updateUrl});

  final Function updateUrl;

  @override
  State<ActivityFormImagePicker> createState() =>
      _ActivityFormImagePickerState();
}

class _ActivityFormImagePickerState extends State<ActivityFormImagePicker> {
  File? _diviceImage;
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker.pickImage(source: source);

    _diviceImage = File(pickedFile!.path);

    if (_diviceImage != null && mounted) {
      print('image ok');
      final String url = await Provider.of<CityProvider>(context, listen: false)
          .uploaImage(_diviceImage!);
      print('URL FINAL : $url');
      widget.updateUrl(url);
      setState(() {});
    } else {
      print('no image');
    }

    try {} catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo),
              label: const Text('Gelerie'),
            ),
            TextButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.photo_camera),
              label: const Text('Camera'),
            )
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 500,
          child: _diviceImage != null
              ? Image.file(_diviceImage!)
              : const Text('Auccune image'),
        )
      ],
    );
  }
}
