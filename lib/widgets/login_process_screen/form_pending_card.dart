import 'package:flutter/material.dart';
import 'card_components.dart';

class FormPendingCard extends StatelessWidget {
  const FormPendingCard({Key key}) : super(key: key);
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
        TextButton(onPressed: () {}, child: const Text('Cerrar sesión')),
      ],
    );
  }
}
