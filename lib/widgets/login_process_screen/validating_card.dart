import 'package:atsa/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ValidatingCard extends StatelessWidget {
  const ValidatingCard({Key key, @required this.email}) : super(key: key);

  final String email;

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
            'Validando identidad',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 28),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.3,
              ),
              children: <TextSpan>[
                const TextSpan(
                  text:
                      'Estamos verificando que seas afiliado de ATSA Santa Cruz, en los próximos días recibirás un correo en tu cuenta ',
                ),
                TextSpan(
                  text: email,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          TextButton(
            onPressed: () => _logout(context),
            child: const Text('Cerrar sesión'),
            style: TextButton.styleFrom(primary: Colors.blue),
          ),
        ],
      ),
    );
  }
}
