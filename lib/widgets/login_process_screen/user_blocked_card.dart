import 'package:atsa/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_components.dart';

class UserBlockedCard extends StatelessWidget {
  const UserBlockedCard({Key key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'Usuario bloqueado'),
        const SizedBox(height: 16),
        const MessageCard(
          message:
              'Uno de los administradores de ATSA Santa Cruz ha bloqueado tu cuenta. Si crees que se trata de un error, por favor, ponete en contacto con nosotros vía WhatsApp.',
        ),
        const SizedBox(height: 8),
        TextButton(onPressed: () => _signOut(context), child: const Text('Cerrar sesión')),
      ],
    );
  }
}
