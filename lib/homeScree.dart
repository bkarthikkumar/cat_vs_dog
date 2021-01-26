import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loadingVar = true;
  File _imageVar;
  List _outputVar;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  distinguishImage(File image) async {
    var outputImage = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _outputVar = outputImage;
      _loadingVar = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assests/model_unquant.tflite', labels: 'assests/labels.txt');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Tflite.close();
  }

  pickImageCamera() async {
    var selImage = await picker.getImage(source: ImageSource.camera);
    if (selImage == null) {
      return null;
    }
    setState(() {
      _imageVar = File(selImage.path);
    });

    distinguishImage(_imageVar);
  }

  pickImageGallery() async {
    var selImage = await picker.getImage(source: ImageSource.gallery);
    if (selImage == null) {
      return null;
    }
    setState(() {
      _imageVar = File(selImage.path);
    });

    distinguishImage(_imageVar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 85),
            Text(
              "TeachableMachine.com CNN part",
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Detect Dog and Cat Screen",
              style: TextStyle(
                  color: Colors.amber[600],
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  fontFamily: 'Times New Roman'),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: _loadingVar
                  ? Container(
                      width: 260,
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/cat.png'),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    )
                  : Container(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width - 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellow[900],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Take a photo',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width - 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red[900],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Camera Roll',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
