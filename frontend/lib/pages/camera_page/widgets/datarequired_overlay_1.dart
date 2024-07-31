import 'package:dev_comp_gen_ai_frontend/core/global_colors.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_functions.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/firestore_repository.dart';
import 'package:flutter/material.dart';

class DatarequiredOverlay1 extends StatefulWidget {
  // display the points for which pictures
  const DatarequiredOverlay1({super.key});

  @override
  State<DatarequiredOverlay1> createState() => _DatarequiredOverlay1State();
}

class _DatarequiredOverlay1State extends State<DatarequiredOverlay1> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getDatarequiredMap();
  }

  Future getDatarequiredMap() async {
    bool fetchNew = true;
    try {
      if (GlobalVariables.datarequiredMap.isNotEmpty) {
        if (GlobalVariables.datarequiredMap.keys.first
            .isAfter(DateTime.now().subtract(const Duration(minutes: 60)))) {
          // do not fetch the datarequired again if the last fetch was less than 1 hours ago
          fetchNew = false;
        }
      }
    } catch (e) {
      fetchNew = true;
    }

    if (fetchNew) {
      // fetch new data
      final datarequiredList = await FirestoreRepository.getDatarequiredList();
      datarequiredList
          .sort((a, b) => (b.pointcat ?? 0).compareTo((a.pointcat ?? 0)));
      GlobalVariables.datarequiredMap = {DateTime.now(): datarequiredList};
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      right: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: loading
            ? const CircularProgressIndicator()
            : Material(
                child: SizedBox(
                  width: GlobalVariables.screenSize.width * 0.4,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount:
                          GlobalVariables.datarequiredMap.values.first.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                GlobalVariables.datarequiredMap.values
                                        .first[index].description ??
                                    "-",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    (GlobalFunctions.pointcatToPoints(
                                                GlobalVariables
                                                    .datarequiredMap
                                                    .values
                                                    .first[index]
                                                    .pointcat) ??
                                            0)
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: GlobalColors.highlight2,
                                    size: 18,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (index > 0) const Divider(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
