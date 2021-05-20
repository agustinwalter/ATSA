import 'package:atsa/helpers/show_toast.dart';
import 'package:atsa/provider/form_provider.dart';
import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkingForm extends StatefulWidget {
  const WorkingForm({Key key}) : super(key: key);
  @override
  _WorkingFormState createState() => _WorkingFormState();
}

class _WorkingFormState extends State<WorkingForm> {
  final TextEditingController _workC = TextEditingController();
  final TextEditingController _professionC = TextEditingController();
  final TextEditingController _fileC = TextEditingController();
  final TextEditingController _phoneC = TextEditingController();
  final TextEditingController _addressC = TextEditingController();
  final TextEditingController _cityC = TextEditingController();
  final TextEditingController _monthC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _workC.dispose();
    _professionC.dispose();
    _fileC.dispose();
    _phoneC.dispose();
    _addressC.dispose();
    _cityC.dispose();
    _monthC.dispose();
  }

  void _sendData() {
    if (_workC.text.isEmpty ||
        _professionC.text.isEmpty ||
        _fileC.text.isEmpty ||
        _phoneC.text.isEmpty ||
        _addressC.text.isEmpty ||
        _cityC.text.isEmpty ||
        _monthC.text.isEmpty) {
      showToast('Todos los campos son obligatorios');
      return;
    }

    Provider.of<FormProvider>(context, listen: false).sendForm(
      work: _workC.text,
      profession: _professionC.text,
      file: _fileC.text,
      workPhone: int.tryParse(_phoneC.text),
      workAddress: _addressC.text,
      workCity: _cityC.text,
      month: _monthC.text,
    );
  }

  void _prevStep() => Provider.of<FormProvider>(context, listen: false).prevStep();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: _prevStep,
            child: const Text('< Volver al paso anterior'),
          ),
        ),
        const SizedBox(height: 5),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Establecimiento donde trabaja',
          icon: Icons.business,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
          controller: _workC,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Profesión',
          icon: Icons.work_outline,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
          controller: _professionC,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Número de legajo o agente',
          icon: Icons.badge,
          keyboardType: TextInputType.text,
          focusColor: Colors.blue,
          controller: _fileC,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Teléfono',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          focusColor: Colors.blue,
          controller: _phoneC,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Domicilio (calle y número)',
          icon: Icons.location_on_outlined,
          keyboardType: TextInputType.streetAddress,
          focusColor: Colors.blue,
          controller: _addressC,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Localidad',
          icon: Icons.map_outlined,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
          controller: _cityC,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Mes de ingreso',
          icon: Icons.event,
          keyboardType: TextInputType.text,
          focusColor: Colors.blue,
          controller: _monthC,
        ),
        const SizedBox(height: 20),
        PrimaryButton(onPressed: _sendData, text: 'Enviar'),
      ],
    );
  }
}
