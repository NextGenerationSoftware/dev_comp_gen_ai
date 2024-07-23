import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  static const platform = MethodChannel('flutter.native/helper');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          String color = "0xFFE65100";
          try {
            final String result = await platform.invokeMethod("changeColor", {
              "color": color,
            });
            print('RESULT -> $result');
            color = result;
          } on PlatformException catch (e) {
            print(e);
          }
        },
        child: const Text("test"),
      ),
    );
  }
}
