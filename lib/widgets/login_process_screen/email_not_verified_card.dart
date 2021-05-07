import 'package:atsa/widgets/general/secondary_button.dart';
import 'package:flutter/material.dart';
import 'card_components.dart';

class EmailNotVerified extends StatelessWidget {
  const EmailNotVerified({Key key}) : super(key: key);

  static const String email = 'agustin.walter9@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'Revisa tu email'),
        const SizedBox(height: 16),
        const MessageCard(message: 'Te enviamos un correo con un link de verificación a $email'),
        const SizedBox(height: 8),
        SecondaryButton(onPressed: () {}, text: 'Reenviar correo'),
        const SizedBox(height: 8),
        TextButton(onPressed: () {}, child: const Text('Cerrar sesión')),
      ],
    );
  }
}
