import 'package:atsa/provider/form_provider.dart';
import 'package:atsa/widgets/affiliation_form/personal_form.dart';
import 'package:atsa/widgets/affiliation_form/working_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AffiliationFormScreen extends StatelessWidget {
  const AffiliationFormScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<FormProvider>(
          builder: (_, FormProvider formProvider, __) {
            final int step = formProvider.formStep;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                Image.asset(
                  'assets/img/logo.png',
                  height: 100,
                  fit: BoxFit.contain,
                ),
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
                    steps: <Step>[
                      Step(
                        title: const Text('Datos personales'),
                        content: const SizedBox.shrink(),
                        isActive: true,
                        state: step == 1 ? StepState.complete : StepState.indexed,
                      ),
                      Step(
                        title: const Text('Datos laborales'),
                        content: const SizedBox.shrink(),
                        isActive: step == 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                if (step == 0) const PersonalForm() else const WorkingForm(),
              ],
            );
          },
        ),
      ),
    );
  }
}
