import 'package:flutter/material.dart';
import 'package:rust_mpc_ffi/lib.dart';

import 'home_page.dart';

void main() {
  runApp(AppWidget());
  CBRustMpc().setup();
  CBRustMpc().connectToLocalHttp();
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
