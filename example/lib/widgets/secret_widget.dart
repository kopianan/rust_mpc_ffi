import 'package:flutter/material.dart';

class SecretWidget extends StatelessWidget {
  const SecretWidget({Key? key, required this.sec, required this.label})
      : super(key: key);

  final TextEditingController sec;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            validator: (e) {
              if (e!.isEmpty) {
                return "Can not be empty ";
              }
              return null;
            },
            maxLines: 9,
            controller: sec,
          ),
        ),
      ],
    );
  }
}
