import 'package:atsa/helpers/show_toast.dart';
import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:atsa/widgets/general/secondary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_components.dart';

class WelcomeCard extends StatefulWidget {
  const WelcomeCard({Key key}) : super(key: key);
  @override
  _WelcomeCardState createState() => _WelcomeCardState();
}

class _WelcomeCardState extends State<WelcomeCard> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  Future<void> _signIn() async {
    if (_emailController.text.isEmpty || _passController.text.isEmpty || _loading) {
      return;
    }
    setState(() => _loading = true);
    try {
      await Provider.of<UserProvider>(context, listen: false).signIn(
        _emailController.text,
        _passController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showToast('El email no es válido');
      } else if (e.code == 'user-disabled') {
        showToast('Este usuario ha sido deshabilitado');
      } else if (e.code == 'wrong-password') {
        showToast('La contraseña es incorrecta');
      }
    } catch (e) {
      showToast('Ocurrió un error inesperado');
      print(e);
    }
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  void _goToCreateAccount() {
    Provider.of<UserProvider>(context, listen: false).goToCreateAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'ATSA Santa Cruz'),
        const SizedBox(height: 16),
        const MessageCard(message: '¡Bienvenido a ATSA Santa Cruz!'),
        const SizedBox(height: 8),
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
          textInputAction: TextInputAction.done,
          labelText: 'Contraseña',
          icon: Icons.vpn_key,
          keyboardType: TextInputType.visiblePassword,
          focusColor: Colors.blue,
          controller: _passController,
        ),
        const SizedBox(height: 8),
        PrimaryButton(
          onPressed: _signIn,
          text: 'Ingresar',
          loading: _loading,
        ),
        const SizedBox(height: 16),
        const MessageCard(message: '¿No tenés cuenta?'),
        const SizedBox(height: 8),
        SecondaryButton(onPressed: _goToCreateAccount, text: 'Registrarme'),
      ],
    );
  }
}
