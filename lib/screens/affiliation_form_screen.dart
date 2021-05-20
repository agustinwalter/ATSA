import 'package:atsa/widgets/affiliation_folder/personal_form.dart';
import 'package:atsa/widgets/affiliation_folder/working_form.dart';
import 'package:flutter/material.dart';

class AffiliationFormScreen extends StatelessWidget {
  const AffiliationFormScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Image.asset('assets/img/logo.png', height: 100, fit: BoxFit.contain),
            const SizedBox(height: 20),
            const Text(
              'ASOCIACIÓN TRABAJADORES DE LA SANIDAD ARGENTINA',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Adherida a FATSA - CGT',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 10),
            const Text(
              'Alvear 840, (9400) Rio Gallegos, Santa Cruz | Tel/Fax: 02966-425379',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const Divider(height: 40),
            const Text(
              'A LA SECRETARÍA GENERAL DE LA ASOCIACIÓN',
              style: TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 10),
            const Text(
              'De acuerdo con los fines de esa Asociación consignados en los Estatutos solicito ingresar como socio de esa Asociación',
              style: TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 72,
              child: Stepper(
                type: StepperType.horizontal,
                steps: const <Step>[
                  Step(
                    title: Text('Datos personales'),
                    content: SizedBox.shrink(),
                    isActive: true,
                  ),
                  Step(
                    title: Text('Datos laborales'),
                    content: SizedBox.shrink(),
                    isActive: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const PersonalForm(),
            // const WorkingForm(),
          ],
        ),
      ),
    );
  }
}
