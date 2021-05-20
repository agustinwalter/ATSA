import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:flutter/material.dart';

class PersonalForm extends StatelessWidget {
  const PersonalForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Nombre(s)',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Apellido(s)',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Número de DNI',
          icon: Icons.contact_mail_outlined,
          keyboardType: TextInputType.number,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Email',
          icon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Teléfono',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Domicilio (calle y número)',
          icon: Icons.location_on_outlined,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Localidad',
          icon: Icons.map_outlined,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Fecha de nacimiento (DD/MM/AA)',
          icon: Icons.event,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Estado civil',
          icon: Icons.people_outline,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        PrimaryButton(onPressed: () {}, text: 'Siguiente paso'),
      ],
    );
  }
}
