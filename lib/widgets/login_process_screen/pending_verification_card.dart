import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/screens/affiliation_form_screen.dart';
import 'package:atsa/widgets/general/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_components.dart';

class PendingVerificationCard extends StatelessWidget {
  const PendingVerificationCard({Key key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).signOut();
  }

  void _goToAfiliationForm(BuildContext context) {
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
        const TitleCard(title: 'Verificación pendiente'),
        const SizedBox(height: 16),
        const MessageCard(
          message:
              'Estamos verificando que seas afiliado de ATSA Santa Cruz, este proceso puede demorar unos días.',
        ),
        const SizedBox(height: 8),
        const MessageCard(
          message: '¿Todavía no sos afiliado de ATSA Santa Cruz?',
        ),
        const SizedBox(height: 8),
        SecondaryButton(onPressed: () => _goToAfiliationForm(context), text: 'Afiliarme'),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => _signOut(context),
          child: const Text('Cerrar sesión'),
        ),
      ],
    );
  }
}
