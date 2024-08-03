import 'dart:convert';
import 'dart:developer';
import 'package:dev_comp_gen_ai_frontend/core/global_functions.dart';
import 'package:http/http.dart' as http;

class BackendRepository {
  static String beUrl1 = true
      ? "http://157.230.105.223:8080" // server Patrick
      : "https://gemini-challenge-be-1-tqgniaizbq-ew.a.run.app"; // server Google

  Future<BackendImagePreview?> backendImagePreview(String imageUrl) async {
    // get a text from the AI what is in the image
    BackendImagePreview? response;

    try {
      http.Response backendResponse = await http.post(
        Uri.parse(BackendRepository.beUrl1 + "/evaluate_picture"),
        body: json.encode({"img_path": imageUrl, "prompt": ""}),
        headers: {"Content-Type": "application/json"},
      );

      try {
        final ret = json.decode(backendResponse.body) as Map<String, dynamic>;
        if (ret.containsKey("findings")) {
          final findings = ret["findings"] as List<dynamic>;
          if (findings.isNotEmpty) {
            final headline = findings.first["finding_headline"] as String;
            final text = findings.first["finding_text"] as String;
            response = BackendImagePreview(
              headline: headline,
              text: text,
            );
          }
        }
      } catch (e) {
        log(e.toString());
        response = null;
      }
    } catch (e) {
      log(e.toString());
      response = null;
    }
    return response;
  }

  Future<BackendImageEvaluation?> backendImageEvaluation(
      String imageUrl, String imageId) async {
    // get the label and points from the AI
    BackendImageEvaluation? response;

    try {
      http.Response backendResponse = await http.post(
        Uri.parse(BackendRepository.beUrl1 + "/get_label_and_points"),
        body: json.encode({"img_path": imageUrl, "prompt": ""}),
        headers: {"Content-Type": "application/json"},
      );

      try {
        final ret = json.decode(backendResponse.body) as Map<String, dynamic>;
        if (ret["findings"].containsKey("findings")) {
          final findings = ret["findings"]["findings"] as List<dynamic>;
          if (findings.isNotEmpty) {
            final label = findings.first["label"] as String;
            final pointcat = findings.first["points"] as int;
            String? datarequiredid;
            try {
              datarequiredid = findings.first["datarequired_id"] as String;
            } catch (e) {
              // no problem, can happen
            }
            final points = GlobalFunctions.pointcatToPoints(pointcat);
            response = BackendImageEvaluation(
              points: points,
              pointcategory: pointcat,
              label: label,
              datarequiredid: datarequiredid,
            );
          }
        }
      } catch (e) {
        log(e.toString());
        // fallback response
        response = BackendImageEvaluation(
          points: 1,
          pointcategory: 1,
          label: "",
        );
      }
    } catch (e) {
      log(e.toString());
      response = null;
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
}

class BackendImageEvaluation {
  int? points;
  int? pointcategory;
  String? label;
  String? datarequiredid;

  BackendImageEvaluation({
    this.points,
    this.pointcategory,
    this.label,
    this.datarequiredid,
  });
}
