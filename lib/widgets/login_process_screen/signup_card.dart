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
  final TextEditingController _passOneController = TextEditingController();
  final TextEditingController _passTwoController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    super.dispose();
    _passOneController.dispose();
    _passTwoController.dispose();
  }

  Future<void> _signUp() async {
    if (_passOneController.text.isEmpty || _passTwoController.text.isEmpty || _loading) {
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
      await Provider.of<UserProvider>(context, listen: false).signUp(_passOneController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
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
        const TitleCard(title: 'Nueva contraseña'),
        const SizedBox(height: 16),
        const MessageCard(message: 'Crea una nueva contraseña, la usarás para acceder a la app'),
        const SizedBox(height: 8),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Nueva contraseña',
          icon: Icons.vpn_key,
          keyboardType: TextInputType.visiblePassword,
          focusColor: Colors.blue,
          obscureText: true,
          controller: _passOneController,
        ),
        const SizedBox(height: 8),
        CustomTextField(
          textInputAction: TextInputAction.done,
          labelText: 'Repite la contraseña',
          icon: Icons.vpn_key,
          keyboardType: TextInputType.visiblePassword,
          focusColor: Colors.blue,
          obscureText: true,
          controller: _passTwoController,
        ),
        const SizedBox(height: 8),
        PrimaryButton(
          onPressed: _signUp,
          text: 'Guardar contraseña',
          loading: _loading,
        ),
      ],
    );
  }
}
