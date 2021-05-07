import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:flutter/material.dart';
import 'card_components.dart';

class SignInCard extends StatelessWidget {
  const SignInCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'Ingresa tu contraseña'),
        const SizedBox(height: 16),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Contraseña',
          icon: Icons.vpn_key,
          keyboardType: TextInputType.visiblePassword,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 8),
        PrimaryButton(onPressed: () {}, text: 'Ingresar'),
      ],
    );
  }
}
