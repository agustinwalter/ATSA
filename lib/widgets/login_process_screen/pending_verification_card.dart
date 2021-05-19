import 'package:atsa/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_components.dart';

class PendingVerificationCard extends StatelessWidget {
  const PendingVerificationCard({Key key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).signOut();
  }

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
        TextButton(
          onPressed: () => _signOut(context),
          child: const Text('Cerrar sesión'),
        ),
      ],
    );
  }
}
