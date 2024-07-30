import 'dart:developer';

class BackendRepository {
  Future<BackendImagePreview?> backendImagePreview(String imageUrl) async {
    // get a text from the AI what is in the image
    BackendImagePreview? response;

    try {
      //TODO: backend implementation

      //! test response
      await Future.delayed(const Duration(seconds: 2));
      response = BackendImagePreview(
        headline: "This is a test headline",
        text: "This is a test text",
      );
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  Future<BackendImageEvaluation?> backendImageEvaluation(
      String imageUrl, String imageId) async {
    // get a text from the AI what is in the image
    BackendImageEvaluation? response;

    try {
      //TODO: backend implementation

      //! test response
      await Future.delayed(const Duration(seconds: 2));
      response = BackendImageEvaluation(
        points: 300,
        pointcategory: 5,
        label: "This is a test label",
      );
    } catch (e) {
      log(e.toString());
    }
    return response;
  }
}

// return values ===============================================================

class BackendImagePreview {
  String? headline;
  String? text;

  BackendImagePreview({
    this.headline,
    this.text,
  });

  BackendImagePreview.fromJson(Map<String, dynamic> json) {
    headline = json['headline'];
    text = json['text'];
  }
}

class BackendImageEvaluation {
  int? points;
  int? pointcategory;
  String? label;

  BackendImageEvaluation({
    this.points,
    this.pointcategory,
    this.label,
  });

  BackendImageEvaluation.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    pointcategory = json['pointcategory'];
    label = json['label'];
  }
}
