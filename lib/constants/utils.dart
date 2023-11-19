import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void showSnackBar({
  required BuildContext context,
  required String text,
  VoidCallback? onTapFunction,
  String? actionLabel,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    onTapFunction != null && actionLabel != null
        ? SnackBar(
            content: Text(text),
            action: SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onTapFunction,
            ),
            behavior: SnackBarBehavior.floating,
          )
        : SnackBar(
            content: Text(text),
            behavior: SnackBarBehavior.floating,
          ),
  );
}

void showErrorSnackBar({
  required BuildContext context,
  required String text,
  VoidCallback? onTapFunction,
  String? actionLabel,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    onTapFunction != null && actionLabel != null
        ? SnackBar(
            content: Text(text),
            action: SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onTapFunction,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color.fromARGB(255, 252, 30, 100),
          )
        : SnackBar(
            content: Text(text),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color.fromARGB(255, 252, 30, 100),
          ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];

  try {
    FilePickerResult? files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint("Error in picking image : ${e.toString()}");
  }

  return images;
}

Future<File> pickImage() async {
  File image = File("");

  try {
    FilePickerResult? file =
        await FilePicker.platform.pickFiles(type: FileType.image);

    image = File(file!.files[0].path!);

    if (file.files.isNotEmpty) {
      image = File(file.files[0].path!);
    }
  } catch (e) {
    debugPrint("Error in picking image : ${e.toString()}");
  }

  return image;
}
