import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEdit extends StatefulWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileEdit({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(context, color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    // final image = NetworkImage(widget.imagePath);
    final image = Image.asset(
      fit: BoxFit.scaleDown,
      height: 100,
      "assets/images/tracter1.png",
    );

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: imageFile == null
              ? image.image
              : FileImage(File(imageFile!.path)),
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: widget.onClicked),
        ),
      ),
    );
  }

  Widget bottomSheat() {
    return Container(
      height: 100,
      width: 300,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(children: [
        const Text(
          "Choose Profile Photo",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                takePhote(ImageSource.camera);
              },
              icon: Icon(Icons.camera),
              label: Text("Camera"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                takePhote(ImageSource.gallery);
              },
              icon: Icon(Icons.image),
              label: Text("Gallery"),
            )
          ],
        )
      ]),
    );
  }

  void takePhote(ImageSource source) async {
    XFile? pickedFile = await picker.pickImage(source: source);

    setState(() {
      imageFile = pickedFile;

      // XFile ximage = await ImagePicker().pickImage(source: ImageSource.camera);

      // load the image as File
      // File image = File(ximage.path);
    });
  }

  Widget buildEditIcon(context, Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: InkWell(
            onTap: () {
              // Navigator.pushNamed(context, '/edit_farmer_profile');

              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheat()),
              );
            },
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}