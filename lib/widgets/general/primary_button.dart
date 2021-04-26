import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    this.loading = false,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            onPressed: onPressed,
            child: loading
                ? const Center(
                    child: SizedBox(
                      height: 19,
                      width: 19,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Text(text, style: const TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
