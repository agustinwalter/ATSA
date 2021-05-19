import 'package:atsa/helpers/show_toast.dart';
import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'card_components.dart';

class UpdateInfoCard extends StatefulWidget {
  const UpdateInfoCard({Key key}) : super(key: key);
  @override
  _UpdateInfoCardState createState() => _UpdateInfoCardState();
}

class _UpdateInfoCardState extends State<UpdateInfoCard> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _dniController.text = Provider.of<UserProvider>(context, listen: false).user?.dni;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _dniController.dispose();
  }

  Future<void> _signOut() async {
    await Provider.of<UserProvider>(context, listen: false).signOut();
  }

  Future<void> _updateInfo() async {
    if (_loading) {
      return;
    }
    if (_nameController.text.isEmpty ||
        _surnameController.text.isEmpty ||
        _dniController.text.isEmpty) {
      showToast('Todos los campos son obligatorios');
      return;
    }
    if (_dniController.text.length > 8) {
      showToast('El DNI debe tener 8 dígitos como máximo');
      return;
    }
    setState(() => _loading = true);
    try {
      await Provider.of<UserProvider>(context, listen: false).updateInfo(
        _nameController.text,
        _surnameController.text,
        _dniController.text,
      );
    } catch (e) {
      showToast('Ocurrió un error inesperado');
      print(e);
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'Actualiza tu información'),
        const SizedBox(height: 16),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Nombre(s)',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
          controller: _nameController,
        ),
        const SizedBox(height: 8),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Apellido(s)',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
          controller: _surnameController,
        ),
        const SizedBox(height: 8),
        CustomTextField(
          textInputAction: TextInputAction.done,
          labelText: 'Número de DNI',
          icon: Icons.contact_mail_outlined,
          keyboardType: TextInputType.number,
          focusColor: Colors.blue,
          controller: _dniController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
        ),
        const SizedBox(height: 8),
        PrimaryButton(onPressed: _updateInfo, text: 'Actualizar', loading: _loading),
        const SizedBox(height: 8),
        TextButton(onPressed: _signOut, child: const Text('Cerrar sesión')),
      ],
    );
  }
}
