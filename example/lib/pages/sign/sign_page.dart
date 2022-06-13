import 'package:flutter/material.dart';
import 'package:rust_mpc_ffi/lib.dart';
import 'package:rust_mpc_ffi_example/pages/widgets/key_output_widget.dart';
import 'package:rust_mpc_ffi_example/storage.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final cbrust = CBRustMpc();
  final TextEditingController sign1 = TextEditingController(),
      sign2 = TextEditingController(),
      sign3 = TextEditingController();
  bool load1 = false, load2 = false, load3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("SIGN PAGE")),
        body: Card(
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Last Sign (2 of 3)",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "This action will generate signature",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  KeyOutputWidget(
                    textController: sign1,
                    isLoading: load1,
                    onPressed: () async {
                      setState(() {
                        load1 = true;
                      });
                      var data = await Storage.loadSecretKey("presign1");
                      sign1.text = await cbrust.sign(1, data!, "message");
                      if ((load1 && load2) || (load1 && load3)) {
                        setState(() {
                          load1 = false;
                          load2 = false;
                          load3 = false;
                        });
                      }
                    },
                    label: "Client Sign",
                  ),
                  KeyOutputWidget(
                    textController: sign2,
                    isLoading: load2,
                    onPressed: () async {
                      setState(() {
                        load2 = true;
                      });
                      var data = await Storage.loadSecretKey("presign2");
                      sign2.text = await cbrust.sign(2, data!, "message");

                      if ((load2 && load1) || (load2 && load3)) {
                        setState(() {
                          load1 = false;
                          load2 = false;
                          load3 = false;
                        });
                      }
                    },
                    label: "Verifier Sign",
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      child: Text("Save Last Key To Local Storage"),
                      onPressed: () async {
                        if (sign1.text.isNotEmpty || sign2.text.isNotEmpty) {
                          await Storage.saveSecretKey('lastKey1', sign1.text);
                          await Storage.saveSecretKey('lastKey2', sign2.text);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Last Key Save"),
                            backgroundColor: Colors.green,
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
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
                ],
              ),
            )));
  }
} 
