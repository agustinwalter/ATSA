import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailCard extends StatefulWidget {
  const EmailCard({Key key}) : super(key: key);

  @override
  _EmailCardState createState() => _EmailCardState();
}

class _EmailCardState extends State<EmailCard> {
  final TextEditingController _emailController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _addEmail() async {
    FocusScope.of(context).unfocus();
    if (_emailController.text.isNotEmpty) {
      setState(() => _loading = true);
      await Provider.of<UserProvider>(context, listen: false).addEmail(
        email: _emailController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 10),
      child: Column(
        children: <Widget>[
          const Text(
            'ATSA Santa Cruz',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 28),
          const Text(
            'Ahora ingresá tu email, revisaremos si sos afiliado y te notificaremos por correo electrónico:',
            style: TextStyle(fontSize: 15, height: 1.3),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _emailController,
            textInputAction: TextInputAction.done,
            labelText: 'Email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            focusColor: Colors.blue,
            onEditingComplete: _addEmail,
          ),
          const SizedBox(height: 16),
          PrimaryButton(onPressed: _addEmail, text: 'Enviar', loading: _loading),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
