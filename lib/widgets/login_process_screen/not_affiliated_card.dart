import 'package:atsa/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotAffiliatedCard extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).logout();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 10),
      child: Column(
        children: <Widget>[
          const Text(
            'Usuario no afiliado',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'No sos afiliado de ATSA Santa Cruz por lo que no podés acceder a los descuentos que ofrecemos.',
            style: TextStyle(
              fontSize: 15,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 18),
          TextButton(
            onPressed: () => _logout(context),
            child: Text('Cerrar sesión'),
            style: TextButton.styleFrom(primary: Colors.blue),
          ),
        ],
      ),
    );
  }
}
