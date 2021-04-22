import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
