import 'package:atsa/screens/affiliation_form_screen.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:flutter/material.dart';

import 'card_components.dart';

class NotAffiliatedCard extends StatelessWidget {
  const NotAffiliatedCard({Key key}) : super(key: key);

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
        const TitleCard(title: 'Aún no estás afiliado'),
        const SizedBox(height: 16),
        const MessageCard(
          message:
              'Aún no sos afiliado de ATSA Santa Cruz. No te preocupes, podés afiliarte ahora mismo desde la app.',
        ),
        const SizedBox(height: 8),
        PrimaryButton(onPressed: () => _goToAfiliationForm(context), text: 'Afiliarme'),
        const SizedBox(height: 8),
        TextButton(onPressed: () {}, child: const Text('Cerrar sesión')),
      ],
    );
  }
}
