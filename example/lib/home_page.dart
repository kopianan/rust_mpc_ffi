import 'dart:isolate';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rust_mpc_ffi/lib.dart';
import 'package:rust_mpc_ffi_example/pages/dkg/dkg_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CBRustMpc cbRustMpc = CBRustMpc();
  final _globalKey = GlobalKey<FormState>();
  TextEditingController sec1 = TextEditingController(),
      sec2 = TextEditingController(),
      sec3 = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Uint8List? s1, s2, s3;
  dynamic? json1, json2, json3;
  final methodChannel = MethodChannel('coinbit_secure_storage');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("MPC"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const DkgPage()));
              },
              child: const Text("GENERATE KEY MPC"),
            ),
            ElevatedButton(
              onPressed: () async {
                final results =
                    await methodChannel.invokeMethod('makeAndStoreKey');
                print(results);
              },
              child: const Text("Storage"),
            ),
          ],
        ),
      ),
    );
  }
}
