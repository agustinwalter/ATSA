import 'package:atsa/helpers/show_toast.dart';
import 'package:atsa/models/atsa_form.dart';
import 'package:atsa/provider/form_provider.dart';
import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PersonalForm extends StatefulWidget {
  const PersonalForm({Key key}) : super(key: key);
  @override
  _PersonalFormState createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _phoneC = TextEditingController();
  final TextEditingController _addressC = TextEditingController();
  final TextEditingController _cityC = TextEditingController();
  final TextEditingController _dateOfBirthC = TextEditingController();
  final TextEditingController _civilStatusC = TextEditingController();

  @override
  void initState() {
    super.initState();
    final AtsaForm form = Provider.of<FormProvider>(context, listen: false).form;
    _phoneC.text = form.personalPhone.toString() == 'null' ? '' : form.personalPhone.toString();
    _addressC.text = form.personalAddress;
    _cityC.text = form.personalCity;
    _dateOfBirthC.text = form.dateOfBirth;
    _civilStatusC.text = form.civilStatus;
  }

  @override
  void dispose() {
    super.dispose();
    _phoneC.dispose();
    _addressC.dispose();
    _cityC.dispose();
    _dateOfBirthC.dispose();
    _civilStatusC.dispose();
  }

  void _setPersonalData() {
    if (_phoneC.text.isEmpty ||
        _addressC.text.isEmpty ||
        _cityC.text.isEmpty ||
        _dateOfBirthC.text.isEmpty ||
        _civilStatusC.text.isEmpty) {
      showToast('Todos los campos son obligatorios');
      return;
    }
    Provider.of<FormProvider>(context, listen: false).setPersonalData(
      personalPhone: int.tryParse(_phoneC.text),
      personalAddress: _addressC.text,
      personalCity: _cityC.text,
      dateOfBirth: _dateOfBirthC.text,
      civilStatus: _civilStatusC.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 20),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Teléfono',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          focusColor: Colors.blue,
          controller: _phoneC,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
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
          labelText: 'Fecha de nacimiento (DD/MM/AA)',
          icon: Icons.event,
          keyboardType: TextInputType.datetime,
          focusColor: Colors.blue,
          controller: _dateOfBirthC,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          textInputAction: TextInputAction.done,
          labelText: 'Estado civil',
          icon: Icons.people_outline,
          keyboardType: TextInputType.text,
          focusColor: Colors.blue,
          controller: _civilStatusC,
        ),
        const SizedBox(height: 20),
        PrimaryButton(onPressed: _setPersonalData, text: 'Siguiente paso'),
      ],
    );
  }
}
