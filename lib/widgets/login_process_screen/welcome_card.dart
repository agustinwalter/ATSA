import 'package:atsa/helpers/show_toast.dart';
import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/screens/affiliation_form_screen.dart';
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
  bool _loading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  Future<void> _checkEmail() async {
    if (_emailController.text.isEmpty && _loading) {
      return;
    }
    setState(() => _loading = true);
    try {
      await Provider.of<UserProvider>(context, listen: false).checkEmail(_emailController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showToast('El email no es válido');
      }
    } catch (e) {
      showToast('Ocurrió un error inesperado');
      print(e);
    }
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  void _goToAffiliationForm() {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (_) => const AffiliationFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TitleCard(title: 'ATSA Santa Cruz'),
        const SizedBox(height: 16),
        const MessageCard(
          message: '¿Sos afiliado de ATSA Santa Cruz? Ingresá tu email para acceder a la app',
        ),
        const SizedBox(height: 8),
        CustomTextField(
          textInputAction: TextInputAction.done,
          labelText: 'Email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          focusColor: Colors.blue,
          controller: _emailController,
        ),
        const SizedBox(height: 8),
        PrimaryButton(
          onPressed: _checkEmail,
          text: 'Ingresar',
          loading: _loading,
        ),
        const SizedBox(height: 24),
        const MessageCard(message: '¿Todavía no te afiliaste?'),
        const SizedBox(height: 8),
        SecondaryButton(onPressed: _goToAffiliationForm, text: 'Afiliarme'),
      ],
    );
  }
}
