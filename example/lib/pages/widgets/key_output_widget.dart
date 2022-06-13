import 'package:flutter/material.dart';

class KeyOutputWidget extends StatelessWidget {
  const KeyOutputWidget(
      {Key? key,
      required this.textController,
      required this.onPressed,
      required this.label,
      this.isLoading = false})
      : super(key: key);
  final Function onPressed;
  final TextEditingController textController;
  final bool isLoading;

  final String label;
  @override
  Widget build(BuildContext context) {
    var loading = Center(
      child: Transform.scale(
          scale: 0.7,
          child: const CircularProgressIndicator(color: Colors.white)),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(children: [
        Expanded(
          flex: 3,
          child: ElevatedButton(
            child: isLoading
                ? loading
                : Text(
                    label,
                    textAlign: TextAlign.center,
                  ),
            onPressed: () {
              onPressed();
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 6,
          child: TextField(
            maxLines: 2,
            minLines: 2,
            controller: textController,
            decoration:
                const InputDecoration(hintText: "Secret will be appear here"),
          ),
        ),
      ]),
    );
  }
}
