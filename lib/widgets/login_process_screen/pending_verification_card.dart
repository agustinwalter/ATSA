import 'package:flutter/material.dart';
import 'card_components.dart';

class PendingVerificationCard extends StatelessWidget {
  const PendingVerificationCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'Verificación pendiente'),
        const SizedBox(height: 16),
        const MessageCard(
            message:
                'Estamos verificando que seas afiliado de ATSA Santa Cruz, este proceso puede demorar unos días.'),
        const SizedBox(height: 8),
        TextButton(onPressed: () {}, child: const Text('Cerrar sesión')),
      ],
    );
  }
}
