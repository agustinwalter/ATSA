import 'package:atsa/helpers/login_status.dart';
import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/widgets/general/wsp_button.dart';
import 'package:atsa/widgets/login_process_screen/email_not_verified_card.dart';
import 'package:atsa/widgets/login_process_screen/form_pending_card.dart';
import 'package:atsa/widgets/login_process_screen/not_affiliated_card.dart';
import 'package:atsa/widgets/login_process_screen/pending_verification_card.dart';
import 'package:atsa/widgets/login_process_screen/signup_card.dart';
import 'package:atsa/widgets/login_process_screen/user_blocked_card.dart';
import 'package:atsa/widgets/login_process_screen/welcome_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginProcessScreen extends StatelessWidget {
  const LoginProcessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: const WspButton(),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
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
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Consumer<UserProvider>(
                        builder: (_, UserProvider userProvider, __) {
                          switch (userProvider.user.status) {
                            case LoginStatus.NOT_LOGGED:
                              return const WelcomeCard();
                            case LoginStatus.CREATE_ACCOUNT:
                              return const SignUpCard();
                            case LoginStatus.EMAIL_NOT_VERIFIED:
                              return const EmailNotVerified();
                            case LoginStatus.PENDING_VERIFICATION:
                              return const PendingVerificationCard();
                            case LoginStatus.BLOCKED:
                              return const UserBlockedCard();
                            case LoginStatus.NOT_AFFILIATED:
                              return const NotAffiliatedCard();
                            case LoginStatus.AFFILIATION_FORM_PENDING:
                              return const FormPendingCard();
                            default:
                              return const SizedBox.shrink();
                          }
                        },
                      ),
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
