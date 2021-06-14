import 'package:atsa/helpers/show_toast.dart';
import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_components.dart';

class CreateAccForAffiliationCard extends StatefulWidget {
  const CreateAccForAffiliationCard({Key key}) : super(key: key);
  @override
  _CreateAccForAffiliationCardState createState() => _CreateAccForAffiliationCardState();
}

class _CreateAccForAffiliationCardState extends State<CreateAccForAffiliationCard> {
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passOneC = TextEditingController();
  final TextEditingController _passTwoC = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    super.dispose();
    _emailC.dispose();
    _passOneC.dispose();
    _passTwoC.dispose();
  }

  Future<void> _signUp() async {
    if (_emailC.text.isEmpty || _passOneC.text.isEmpty || _passTwoC.text.isEmpty || _loading) {
      showToast('Todos los campos son obligatorios');
      return;
    }
    if (_passOneC.text.length < 8 || _passOneC.text.length > 16) {
      showToast('La contraseña debe tener entre 8 y 16 caracteres');
      return;
    }
    if (_passOneC.text != _passTwoC.text) {
      showToast('Las contraseñas no coinciden');
      return;
    }
    setState(() => _loading = true);
    try {
      Provider.of<UserProvider>(context, listen: false).setEmail(_emailC.text);
      await Provider.of<UserProvider>(context, listen: false).signUp(_passOneC.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast('Este email ya está registrado');
      }
      if (e.code == 'invalid-email') {
        showToast('El email no es válido');
      }
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
        const TitleCard(title: 'Crea una cuenta'),
        const SizedBox(height: 16),
        const MessageCard(message: 'Antes de afiliarte es necesario que crees una cuenta:'),
        const SizedBox(height: 8),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          focusColor: Colors.blue,
          controller: _emailC,
        ),
        const SizedBox(height: 8),
        CustomTextField(
          textInputAction: TextInputAction.next,
          labelText: 'Nueva contraseña',
          icon: Icons.vpn_key,
          keyboardType: TextInputType.visiblePassword,
          focusColor: Colors.blue,
          obscureText: true,
          controller: _passOneC,
        ),
        const SizedBox(height: 8),
        CustomTextField(
          textInputAction: TextInputAction.done,
          labelText: 'Repite la contraseña',
          icon: Icons.vpn_key,
          keyboardType: TextInputType.visiblePassword,
          focusColor: Colors.blue,
          obscureText: true,
          controller: _passTwoC,
        ),
        const SizedBox(height: 8),
        PrimaryButton(
          onPressed: _signUp,
          text: 'Crear cuenta',
          loading: _loading,
        ),
      ],
    );
  }
}
