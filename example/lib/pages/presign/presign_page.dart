import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rust_mpc_ffi/lib.dart';
import 'package:rust_mpc_ffi_example/pages/sign/sign_page.dart';
import 'package:rust_mpc_ffi_example/storage.dart';
import '../widgets/key_output_widget.dart';

class PresignPage extends StatefulWidget {
  const PresignPage({Key? key}) : super(key: key);

  @override
  State<PresignPage> createState() => _PresignPageState();
}

class _PresignPageState extends State<PresignPage> {
  final _cbRustMpc = CBRustMpc();
  final _storage = Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OFFLINE SIGN"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Card(
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  DefaultPresign(cbRustMpc: _cbRustMpc),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignPage()));
                        },
                        child: const Text("GO TO SIGN PAGE")),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class DefaultPresign extends StatefulWidget {
  const DefaultPresign({
    Key? key,
    required CBRustMpc cbRustMpc,
  })  : _cbRustMpc = cbRustMpc,
        super(key: key);

  final CBRustMpc _cbRustMpc;

  @override
  State<DefaultPresign> createState() => _DefaultPresignState();
}

class _DefaultPresignState extends State<DefaultPresign> {
  final secret1 = TextEditingController(), secret2 = TextEditingController();
  bool load1 = false, load2 = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Default Presign (2 of 3)",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "This action will secret from generated DKG from previous page",
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            KeyOutputWidget(
              isLoading: load1,
              label: "Client Presign",
              textController: secret1,
              onPressed: () async {
                setState(() {
                  load1 = true;
                });
                var jsonData = await Storage.loadSecretKey('secret1');
                log(jsonData.toString());

                var presignKey =
                    await widget._cbRustMpc.offlineSignWithJson(1, jsonData!);
                secret1.text = presignKey;
                await Storage.saveSecretKey("presign1", presignKey);
                if ((load1 && load2)) {
                  setState(() {
                    load1 = false;
                    load2 = false;
                  });
                }
              },
            ),
            KeyOutputWidget(
              isLoading: load2,
              label: "Verifier Presign",
              textController: secret2,
              onPressed: () async {
                setState(() {
                  load2 = true;
                });
                var jsonData = await Storage.loadSecretKey('secret2');

                var presignKey =
                    await widget._cbRustMpc.offlineSignWithJson(2, jsonData!);
                secret2.text = presignKey;
                await Storage.saveSecretKey("presign2", presignKey);

                if ((load2 && load1)) {
                  setState(() {
                    load1 = false;
                    load2 = false;
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
