import 'package:atsa/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CredentialScreen extends StatelessWidget {
  const CredentialScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credencial ATSA'),
        centerTitle: true,
      ),
      body: Consumer<UserProvider>(
        builder: (BuildContext _, UserProvider userProvider, Widget __) {
          if (userProvider.atsaUser.status == 'Afiliado') {
            return Column(
              children: <Widget>[
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          right: -38,
                          top: -72,
                          child: Container(
                            width: 188,
                            height: 188,
                            decoration: BoxDecoration(
                              color: Colors.green[100].withOpacity(.5),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          right: -38,
                          top: -40,
                          child: Container(
                            width: 158,
                            height: 158,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check_circle_outline_outlined,
                              size: 60,
                              color: Colors.green[200],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Usuario',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                Provider.of<UserProvider>(context, listen: false)
                                    .atsaUser
                                    .status
                                    .toUpperCase(),
                                style: const TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          right: -38,
                          top: -72,
                          child: Container(
                            width: 188,
                            height: 188,
                            decoration: BoxDecoration(
                              color: Colors.blue[100].withOpacity(.5),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          right: -34,
                          top: -38,
                          child: Container(
                            width: 158,
                            height: 158,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.contact_mail_outlined,
                              size: 60,
                              color: Colors.blue[200],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Número de DNI',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                Provider.of<UserProvider>(context, listen: false).atsaUser.dni,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(Icons.info_outline_rounded, color: Colors.blue),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: const <Widget>[
                              Text(
                                'Compruebe que la credencial sea válida, verificando que la siguente linea se encuentre en movimiento:',
                              ),
                              SizedBox(height: 16),
                              LinearProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/img/logo.png',
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          } else {
            return _noCredential();
          }
        },
      ),
    );
  }

  Widget _noCredential() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(
            Icons.info_outline_rounded,
            color: Colors.orangeAccent,
            size: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 20),
            child: Text(
              'Credencial Inválida',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Text('Por algún motivo, esta credencial fue desactivada.')
        ],
      ),
    );
  }
}
