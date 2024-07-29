import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_functions.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/ai_repository.dart';
import 'package:dev_comp_gen_ai_frontend/pages/camera_page/widgets/camera_page_header.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  static const route = "/camera";
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? cameraController;
  String? aiInformation;

  Future initialize() async {
    GlobalVariables.cameraDescriptions = await availableCameras();
    cameraController = CameraController(
        GlobalVariables.cameraDescriptions[0], ResolutionPreset.max);
    cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future onCameraTap() async {
    final imageFile = await cameraController?.takePicture();
    if (imageFile != null) {
      Uint8List imageByteList = await imageFile.readAsBytes();
      aiInformation = await AiRepository().analyzeImage(imageByteList);
      setState(() {});
    } else {
      GlobalFunctions.showInfo1(
          context: context, message: "Image couldn't be taken.");
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        const CameraPageHeader(),
        Expanded(
          child: cameraController?.value.isInitialized == true
              ? Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        onCameraTap();
                      },
                      child: SizedBox(
                        width: screenSize.width,
                        height: screenSize.height,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            height: screenSize.height,
                            child: CameraPreview(
                              cameraController!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    (aiInformation ?? "").isEmpty
                        ? const SizedBox()
                        : Center(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(50),
                              constraints: BoxConstraints(
                                maxWidth: screenSize.width * 0.5,
                                maxHeight: screenSize.height * 0.5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SingleChildScrollView(
                                child: Text(
                                  aiInformation!,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                //TODO: display the notifications history
                              },
                              icon: const Icon(
                                Icons.message,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.camera,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            IconButton(
                              onPressed: () {
                                //TODO: display the points for which pictures
                              },
                              icon: const Icon(
                                Icons.info,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ],
    );
  }
}
