import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:atsa/widgets/general/secondary_button.dart';
import 'package:flutter/material.dart';
import 'card_components.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'ATSA Santa Cruz'),
        const SizedBox(height: 16),
        const MessageCard(message: '¿Ya sos afiliado? Ingresá tu email para acceder a la app'),
        const SizedBox(height: 8),
        const CustomTextField(
          textInputAction: TextInputAction.done,
          labelText: 'Email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 8),
        PrimaryButton(onPressed: () {}, text: 'Ingresar', loading: false),
        const SizedBox(height: 24),
        const MessageCard(message: '¿Todavía no te afiliaste?'),
        const SizedBox(height: 8),
        SecondaryButton(onPressed: () {}, text: 'Afiliarme'),
      ],
    );
  }
}
