import 'package:atsa/models/AtsaUser.dart';
import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/widgets/login_process_screen/dni_card.dart';
import 'package:atsa/widgets/login_process_screen/email_card.dart';
import 'package:atsa/widgets/login_process_screen/not_affiliated_card.dart';
import 'package:atsa/widgets/login_process_screen/user_blocked.dart';
import 'package:atsa/widgets/login_process_screen/validating_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginProcessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 28, 18, 28),
          shrinkWrap: true,
          children: <Widget>[
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/img/logo.png',
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),
                  Card(
                    elevation: 4,
                    child: Consumer<UserProvider>(
                      builder: (BuildContext _, UserProvider userProvider, Widget __) {
                        AtsaUser user = userProvider.atsaUser;
                        if (user == null) {
                          return DNICard();
                        }
                        switch (user.status) {
                          case 'Verificación pendiente':
                            return ValidatingCard(email: user.email);
                          case 'No afiliado':
                            return NotAffiliatedCard();
                          case 'Bloqueado':
                            return UserBlocked();
                          case 'Falta email':
                            return EmailCard();
                          default:
                            return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
