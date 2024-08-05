import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/db_datataken.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/notification_data.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_functions.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/backend_repository.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/firestore_repository.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/storage_repository.dart';
import 'package:dev_comp_gen_ai_frontend/pages/camera_page/widgets/camera_page_header.dart';
import 'package:dev_comp_gen_ai_frontend/pages/camera_page/widgets/congratulation_popup_1.dart';
import 'package:dev_comp_gen_ai_frontend/pages/camera_page/widgets/datarequired_overlay_1.dart';
import 'package:dev_comp_gen_ai_frontend/pages/camera_page/widgets/image_evaluated_1.dart';
import 'package:dev_comp_gen_ai_frontend/pages/camera_page/widgets/image_preview_1.dart';
import 'package:dev_comp_gen_ai_frontend/pages/camera_page/widgets/new_notification_overlay_1.dart';
import 'package:dev_comp_gen_ai_frontend/pages/camera_page/widgets/notification_history_overlay_1.dart';
import 'package:dev_comp_gen_ai_frontend/pages/camera_page/widgets/verify_image_label_1.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  static const route = "/camera";
  static bool takingImageLoading = false;
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? cameraController;
  String? aiInformation;

  late OverlayEntry datarequiredOverlayEntry;
  late OverlayEntry notificationhistoryOverlayEntry;
  late OverlayEntry newNotificationOverlayEntry;
  Timer? previewTimer;

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
    datarequiredOverlayEntry = OverlayEntry(
      builder: (context) {
        return const DatarequiredOverlay1();
      },
    );
    notificationhistoryOverlayEntry = OverlayEntry(
      builder: (context) {
        return NotificationHistoryOverlay1(
          onDetails: () {
            try {
              notificationhistoryOverlayEntry.remove();
            } catch (e) {
              // no problem, can happen
            }
          },
        );
      },
    );
    previewTimer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      previewImage();
    });
    initialize();
  }

  displayDataRequired() {
    if (datarequiredOverlayEntry.mounted) {
      datarequiredOverlayEntry.remove();
    } else {
      Overlay.of(context).insert(datarequiredOverlayEntry);
    }
  }

  displayNotificationHistory() {
    // close notification
    try {
      newNotificationOverlayEntry.remove();
    } catch (e) {
      // no problem can happen
    }
    // display the notification history
    if (notificationhistoryOverlayEntry.mounted) {
      notificationhistoryOverlayEntry.remove();
    } else {
      Overlay.of(context).insert(notificationhistoryOverlayEntry);
    }
  }

  displayNewNotification(NotificationData notificationData) async {
    // display a new notification for some time and remove it afterwards
    try {
      if (mounted &&
          !notificationhistoryOverlayEntry.mounted &&
          !CameraPage.takingImageLoading &&
          GlobalVariables.currentRoute == CameraPage.route) {
        // only process when camera_page is the current route
        newNotificationOverlayEntry = OverlayEntry(
          builder: (context) {
            return NewNotificationOverlay1(
              notificationData: notificationData,
              onDetails: () {
                // close all popups
                try {
                  notificationhistoryOverlayEntry.remove();
                } catch (e) {
                  // no problem can happen
                }
                try {
                  datarequiredOverlayEntry.remove();
                } catch (e) {
                  // no problem can happen
                }
                try {
                  newNotificationOverlayEntry.remove();
                } catch (e) {
                  // no problem can happen
                }
              },
            );
          },
        );
        Overlay.of(context).insert(newNotificationOverlayEntry);
        await Future.delayed(const Duration(seconds: 3));
        newNotificationOverlayEntry.remove();
      }
    } catch (e) {
      // no problem, can happen
    }
  }

  Future previewImage() async {
    // trigger in a time interval so the user gets notifications about what can be seen through his camera
    final imageFile = await cameraController?.takePicture();
    if (imageFile != null) {
      // take image
      Uint8List imageByteList = await imageFile.readAsBytes();
      // upload image to storage and get url
      String newId = GlobalFunctions.createUid();
      String path = "${GlobalVariables.DEVUSERID}/$newId";
      String? url = await StorageRepository.uploadAndGetUrl(imageByteList, path,
          autodelete: true);
      // get AI-Response for this image
      BackendImagePreview? backendImagePreview =
          await BackendRepository().backendImagePreview(url!);
      if (backendImagePreview != null) {
        // create a notification
        NotificationData notificationData = NotificationData(
          headline: backendImagePreview.headline,
          text: backendImagePreview.text,
          timestamp: DateTime.now(),
        );
        // add a notification to the list
        GlobalFunctions.addNotificationToHistory(notificationData);
        // display notifcation
        displayNewNotification(notificationData);
      } else {
        // image couldn't be processed
        // display no error message
      }
    } else {
      // image couldn't be taken
      // display no error message
    }
  }

  Future takeImage() async {
    setState(() {
      CameraPage.takingImageLoading = true;
    });
    // close all popups
    try {
      notificationhistoryOverlayEntry.remove();
    } catch (e) {
      // no problem can happen
    }
    try {
      datarequiredOverlayEntry.remove();
    } catch (e) {
      // no problem can happen
    }
    try {
      newNotificationOverlayEntry.remove();
    } catch (e) {
      // no problem can happen
    }
    // trigger when the user wants to send a picture to the backend
    XFile? imageFile;
    for (int i = 0; i < 100; i++) {
      // try to get a picture for 1 second
      try {
        imageFile = await cameraController?.takePicture();
      } catch (e) {
        // may interfer with image preview
        await Future.delayed(const Duration(milliseconds: 10));
        continue;
      }
      break;
    }

    if (imageFile != null) {
      // prepare datataken data
      String newId = GlobalFunctions.createUid();
      DBDatataken dbDatataken = DBDatataken(
          id: newId,
          userid: GlobalVariables.DEVUSERID,
          path: "${GlobalVariables.DEVUSERID}/$newId");
      // preview image
      String? imageUrl = await GlobalFunctions.launchPopup1(
        context: context,
        barrierDismissible: false,
        child: ImagePreview1(
          imageFile: imageFile,
          path: dbDatataken.path!,
        ),
      );
      if (imageUrl != null) {
        dbDatataken.url = imageUrl;
        // get AI-Response for this image
        BackendImageEvaluation? backendImageEvaluation =
            await GlobalFunctions.launchPopup1(
          context: context,
          barrierDismissible: false,
          child: ImageEvaluated1(
            imageUrl: dbDatataken.url!,
            imageId: dbDatataken.id!,
          ),
        );
        if (backendImageEvaluation != null) {
          // verify label
          String? verifiedLabel = await GlobalFunctions.launchPopup1(
            context: context,
            barrierDismissible: false,
            child: VerifyImageLabel1(
              imageFile: imageFile,
              label: backendImageEvaluation.label ?? "",
            ),
          );
          // save datataken to database
          dbDatataken.points = backendImageEvaluation.points;
          dbDatataken.pointcat = backendImageEvaluation.pointcategory;
          dbDatataken.pointcat = backendImageEvaluation.pointcategory;
          dbDatataken.datarequiredid = backendImageEvaluation.datarequiredid;
          dbDatataken.timestamp = Timestamp.now().toDate();
          dbDatataken.label = verifiedLabel;
          FirestoreRepository.uploadDatataken(
              dbDatataken:
                  dbDatataken); // do not await this for better user experience
          // update pointstats locally
          GlobalVariables.pointStatsData!.totalImages =
              GlobalVariables.pointStatsData!.totalImages! + 1;
          GlobalVariables.pointStatsData!.totalPoints =
              GlobalVariables.pointStatsData!.totalPoints! +
                  (dbDatataken.points ?? 0);
          // display congratulations
          await GlobalFunctions.launchPopup1(
            context: context,
            child: CongratulationPopup1(
              points: dbDatataken.points ?? 0,
            ),
          );
        } else {
          GlobalFunctions.showInfo1(
              context: context, message: "Image couldn't be processed.");
        }
      } else {
        /*GlobalFunctions.showInfo1(
            context: context, message: "Image couldn't be uploaded.");*/
      }
    } else {
      GlobalFunctions.showInfo1(
          context: context, message: "Image couldn't be taken.");
    }
    setState(() {
      CameraPage.takingImageLoading = false;
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    previewTimer?.cancel();
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
                    SizedBox(
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
                                displayNotificationHistory();
                              },
                              icon: const Icon(
                                Icons.message,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: CameraPage.takingImageLoading
                                  ? const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: CircularProgressIndicator(),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        takeImage();
                                      },
                                      icon: const Icon(
                                        Icons.camera,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                            ),
                            const Expanded(child: SizedBox()),
                            /*IconButton(
                                onPressed: () {
                                  previewImage();
                                },
                                icon: const Icon(Icons.telegram,
                                    color: Colors.white, size: 30)),*/
                            IconButton(
                              onPressed: () {
                                displayDataRequired();
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
