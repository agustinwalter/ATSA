import 'package:flutter/material.dart';
import 'card_components.dart';

class UserBlockedCard extends StatelessWidget {
  const UserBlockedCard({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'Usuario bloqueado'),
        const SizedBox(height: 16),
        const MessageCard(
            message:
                'Uno de los administradores de ATSA Santa Cruz ha bloqueado tu cuenta. Si crees que se trata de un error, por favor, ponete en contacto con nosotros vía WhatsApp.'),
        const SizedBox(height: 8),
        TextButton(onPressed: () {}, child: const Text('Cerrar sesión')),
      ],
    );
  }
}
