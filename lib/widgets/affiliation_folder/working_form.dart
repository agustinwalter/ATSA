import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:flutter/material.dart';

class WorkingForm extends StatelessWidget {
  const WorkingForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Establecimiento donde trabaja',
          icon: Icons.business,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Profesión',
          icon: Icons.work_outline,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        const CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Número de legajo o agente',
          icon: Icons.badge,
          keyboardType: TextInputType.text,
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
          labelText: 'Mes de ingreso',
          icon: Icons.event,
          keyboardType: TextInputType.emailAddress,
          focusColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        PrimaryButton(onPressed: () {}, text: 'Enviar'),
      ],
    );
  }
}
