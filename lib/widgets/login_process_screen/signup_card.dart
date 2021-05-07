import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:flutter/material.dart';
import 'card_components.dart';

class SignUpCard extends StatelessWidget {
  const SignUpCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'Nueva contraseña'),
        const SizedBox(height: 16),
        const MessageCard(message: 'Crea una nueva contraseña, la usarás para acceder a la app'),
        const SizedBox(height: 8),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Nueva contraseña',
          icon: Icons.vpn_key,
          keyboardType: TextInputType.visiblePassword,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 8),
        const CustomTextField(
          textInputAction: TextInputAction.done,
          labelText: 'Repite la contraseña',
          icon: Icons.vpn_key,
          keyboardType: TextInputType.visiblePassword,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 8),
        PrimaryButton(onPressed: () {}, text: 'Guardar contraseña'),
      ],
    );
  }
}
