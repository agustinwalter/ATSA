import 'package:atsa/helpers/show_toast.dart';
import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_components.dart';

class SignInCard extends StatefulWidget {
  const SignInCard({Key key}) : super(key: key);
  @override
  _SignInCardState createState() => _SignInCardState();
}

class _SignInCardState extends State<SignInCard> {
  final TextEditingController _passController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    super.dispose();
    _passController.dispose();
  }

  Future<void> _signIn() async {
    if (_passController.text.isEmpty || _loading) {
      return;
    }
    setState(() => _loading = true);
    try {
      await Provider.of<UserProvider>(context, listen: false).signIn(_passController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'Ingresa tu contraseña'),
        const SizedBox(height: 16),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Contraseña',
          icon: Icons.vpn_key,
          keyboardType: TextInputType.visiblePassword,
          focusColor: Colors.blue,
          obscureText: true,
          controller: _passController,
        ),
        const SizedBox(height: 8),
        PrimaryButton(onPressed: _signIn, text: 'Continuar'),
      ],
    );
  }
}
