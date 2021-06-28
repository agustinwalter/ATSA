import 'package:atsa/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_components.dart';

class FormPendingCard extends StatelessWidget {
  const FormPendingCard({Key key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'Afiliación pendiente'),
        const SizedBox(height: 16),
        const MessageCard(
          message:
              'Recibimos tu formulario y estamos revisando tus datos. Pronto te contactaremos por email informándote si se aprobó tu afiliación o no.',
        ),
        const SizedBox(height: 8),
        TextButton(onPressed: () => _signOut(context), child: const Text('Cerrar sesión')),
      ],
    );
  }
}
