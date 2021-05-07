import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:flutter/material.dart';
import 'card_components.dart';

class UpdateInfoCard extends StatelessWidget {
  const UpdateInfoCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'Actualiza tu información'),
        const SizedBox(height: 16),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Nombre(s)',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 8),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Apellido(s)',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 8),
        const CustomTextField(
          textInputAction: TextInputAction.done,
          labelText: 'Número de DNI',
          icon: Icons.contact_mail_outlined,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 8),
        PrimaryButton(onPressed: () {}, text: 'Actualizar', loading: false),
      ],
    );
  }
}
