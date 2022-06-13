import 'package:flutter/material.dart';
import 'package:rust_mpc_ffi/lib.dart';
import 'package:rust_mpc_ffi_example/pages/presign/presign_page.dart';
import 'package:rust_mpc_ffi_example/pages/widgets/key_output_widget.dart';
import 'package:rust_mpc_ffi_example/storage.dart';

class DkgPage extends StatefulWidget {
  const DkgPage({Key? key}) : super(key: key);

  @override
  State<DkgPage> createState() => _DkgPageState();
}

class _DkgPageState extends State<DkgPage> {
  final _cbRustMpc = CBRustMpc();
  final dkgController1 = TextEditingController();
  final dkgController2 = TextEditingController();
  final dkgController3 = TextEditingController();
  bool load1 = false, load2 = false, load3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DKG HERE")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            KeyOutputWidget(
                label: "DKG 1",
                isLoading: load1,
                textController: dkgController1,
                onPressed: () async {
                  setState(() {
                    load1 = true;
                  });
                  var secret = await _cbRustMpc.proccessDkgString(1);
                  setState(() {
                    load1 = false;
                    dkgController1.text = secret;
                  });
                }),
            KeyOutputWidget(
                label: "DKG 2",
                isLoading: load2,
                textController: dkgController2,
                onPressed: () async {
                  setState(() {
                    load2 = true;
                  });
                  var secret = await _cbRustMpc.proccessDkgString(2);
                  setState(() {
                    load2 = false;
                    dkgController2.text = secret;
                  });
                }),
            KeyOutputWidget(
              label: "DKG 3",
              isLoading: load3,
              textController: dkgController3,
              onPressed: () async {
                setState(() {
                  load3 = true;
                });
                var secret = await _cbRustMpc.proccessDkgString(3);
                setState(() {
                  load3 = false;
                  dkgController3.text = secret;
                });
              },
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: Text("Save Key To Local Storage"),
                onPressed: () async {
                  if (dkgController1.text.isNotEmpty ||
                      dkgController2.text.isNotEmpty ||
                      dkgController3.text.isNotEmpty) {
                    await Storage.saveSecretKey('secret1', dkgController1.text);
                    await Storage.saveSecretKey('secret2', dkgController2.text);
                    await Storage.saveSecretKey('secret3', dkgController3.text);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Secret Saved"),
                      backgroundColor: Colors.green,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Can not save secret",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PresignPage()));
              },
              child: Text("Go To Presign Page"),
            ),
          ],
        ),
      ),
    );
  }
}
