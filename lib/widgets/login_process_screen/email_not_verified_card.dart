import 'package:atsa/helpers/show_toast.dart';
import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/widgets/general/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_components.dart';

class EmailNotVerified extends StatefulWidget {
  const EmailNotVerified({Key key}) : super(key: key);
  @override
  _EmailNotVerifiedState createState() => _EmailNotVerifiedState();
}

class _EmailNotVerifiedState extends State<EmailNotVerified> with WidgetsBindingObserver {
  bool _loading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      setState(() => _loading = true);
      try {
        await Provider.of<UserProvider>(context, listen: false).checkEmailVerification();
      } catch (e) {
        print(e);
      }
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _signOut() async {
    await Provider.of<UserProvider>(context, listen: false).signOut();
  }

  Future<void> _resendEmail() async {
    showToast('Se ha reenviado el correo de verificación');
    await Provider.of<UserProvider>(context, listen: false).resendEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const TitleCard(title: 'Revisa tu email'),
            const SizedBox(height: 16),
            Consumer<UserProvider>(
              builder: (BuildContext _, UserProvider userProvider, Widget __) {
                return MessageCard(
                  message:
                      'Te enviamos un correo con un link de verificación a ${userProvider.user.email}',
                );
              },
            ),
            const SizedBox(height: 8),
            SecondaryButton(onPressed: _resendEmail, text: 'Reenviar correo'),
            const SizedBox(height: 8),
            TextButton(onPressed: _signOut, child: const Text('Cerrar sesión')),
          ],
        ),
        if (_loading)
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white.withOpacity(.8),
              child: const Center(child: CircularProgressIndicator()),
            ),
          )
      ],
    );
  }
}
