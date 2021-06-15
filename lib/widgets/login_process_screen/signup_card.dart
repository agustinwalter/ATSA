import 'package:atsa/helpers/show_toast.dart';
import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_components.dart';

class SignUpCard extends StatefulWidget {
  const SignUpCard({Key key}) : super(key: key);
  @override
  _SignUpCardState createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passOneController = TextEditingController();
  final TextEditingController _passTwoController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passOneController.dispose();
    _passTwoController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _dniController.dispose();
  }

  Future<void> _signUp() async {
    if (_loading) {
      return;
    }
    if (_emailController.text.isEmpty ||
        _passOneController.text.isEmpty ||
        _passTwoController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _surnameController.text.isEmpty ||
        _dniController.text.isEmpty) {
      showToast('Todos los campos son obligatorios');
      return;
    }
    if (_passOneController.text.length < 8 || _passOneController.text.length > 16) {
      showToast('La contraseña debe tener entre 8 y 16 caracteres');
      return;
    }
    if (_passOneController.text != _passTwoController.text) {
      showToast('Las contraseñas no coinciden');
      return;
    }
    setState(() => _loading = true);
    try {
      await Provider.of<UserProvider>(context, listen: false).signUp(
        email: _emailController.text,
        password: _passOneController.text,
        name: _nameController.text,
        surname: _surnameController.text,
        dni: _dniController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast('Este email ya está registrado');
      } else if (e.code == 'invalid-email') {
        showToast('El email no es válido');
      } else if (e.code == 'weak-password') {
        showToast('La contraseña es insegura, intenta combinar letras y números');
      }
    } catch (e) {
      showToast('Ocurrió un error inesperado');
      print(e);
    }
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'Registrate'),
        const SizedBox(height: 16),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          focusColor: Colors.blue,
          controller: _emailController,
        ),
        const SizedBox(height: 8),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Contraseña',
          icon: Icons.vpn_key,
          keyboardType: TextInputType.visiblePassword,
          focusColor: Colors.blue,
          controller: _passOneController,
          obscureText: true,
        ),
        const SizedBox(height: 8),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Repite la contraseña',
          icon: Icons.vpn_key,
          keyboardType: TextInputType.visiblePassword,
          focusColor: Colors.blue,
          obscureText: true,
          controller: _passTwoController,
        ),
        const SizedBox(height: 8),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Nombre',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
          controller: _nameController,
        ),
        const SizedBox(height: 8),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Apellido',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
          focusColor: Colors.blue,
          controller: _surnameController,
        ),
        const SizedBox(height: 8),
        CustomTextField(
          textInputAction: TextInputAction.done,
          labelText: 'DNI',
          icon: Icons.contact_mail_outlined,
          keyboardType: TextInputType.number,
          focusColor: Colors.blue,
          controller: _dniController,
        ),
        const SizedBox(height: 8),
        const Text(
          'Si ya habías usado la versión anterior de ATSA Santa cruz, recuperaremos tus datos de afiliación automáticamente.',
        ),
        const SizedBox(height: 8),
        PrimaryButton(
          onPressed: _signUp,
          text: 'Registrarme',
          loading: _loading,
        ),
      ],
    );
  }
}
