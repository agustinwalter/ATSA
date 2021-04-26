import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/screens/business_screen.dart';
import 'package:atsa/screens/login_process_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<UserProvider>(create: (BuildContext _) => UserProvider()),
      ],
      child: const ATSA(),
    ),
  );
}

class ATSA extends StatefulWidget {
  const ATSA({Key key}) : super(key: key);

  @override
  _ATSAState createState() => _ATSAState();
}

class _ATSAState extends State<ATSA> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATSA Santa Cruz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<void>(
        future: _initialization,
        builder: (_, AsyncSnapshot<void> snapshot) {
          // Error.
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('Algo salió mal'),
              ),
            );
          }
          // Login or business.
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<UserProvider>(
              builder: (BuildContext _, UserProvider userProvider, Widget __) {
                if (userProvider.atsaUser != null) {
                  if (userProvider.atsaUser.status == 'Afiliado') {
                    return const BusinessScreen();
                  }
                }
                return const LoginProcessScreen();
              },
            );
          }
          // Loading.
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
