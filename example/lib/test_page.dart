import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rust_mpc_ffi/lib.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Visibility(
          child: GridView.count(
            shrinkWrap: true,
            childAspectRatio: 2 / 0.6,
            crossAxisSpacing: 10,
            crossAxisCount: 3,
            children: [
              ElevatedButton(
                onPressed: () async {
                  var _stringJson =
                      await rootBundle.loadString('assets/local-key1.json');
                },
                child: Text("Load Local Key 1 And Convert"),
              ),
              ElevatedButton(
                onPressed: () async {},
                child: Text("Load Local Key 2 And Convert"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
