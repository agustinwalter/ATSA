import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/widgets/general/custom_text_field.dart';
import 'package:atsa/widgets/general/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DNICard extends StatefulWidget {
  const DNICard({Key key}) : super(key: key);

  @override
  _DNICardState createState() => _DNICardState();
}

class _DNICardState extends State<DNICard> {
  final TextEditingController _dniController = TextEditingController();

  @override
  void dispose() {
    _dniController.dispose();
    super.dispose();
  }

  Future<void> _checkDNI() async {
    FocusScope.of(context).unfocus();
    if (_dniController.text.isNotEmpty) {
      Provider.of<UserProvider>(context, listen: false).initUser(
        dni: _dniController.text,
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
            'Ingresá tu número de DNI para acceder a la app:',
            style: TextStyle(fontSize: 15, height: 1.3),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _dniController,
            textInputAction: TextInputAction.done,
            onEditingComplete: _checkDNI,
            keyboardType: TextInputType.number,
            labelText: 'Número de DNI',
            icon: Icons.contact_mail_outlined,
            focusColor: Colors.blue,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 16),
          Consumer<UserProvider>(
            builder: (BuildContext _, UserProvider userProvider, Widget __) {
              return PrimaryButton(
                onPressed: _checkDNI,
                text: 'Ingresar',
                loading: userProvider.loading,
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
