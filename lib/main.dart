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
      child: ATSA(),
    ),
  );
}

class ATSA extends StatefulWidget {
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
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Error.
          if (snapshot.hasError) {
            return Scaffold(
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
                    return BusinessScreen();
                  }
                }
                return LoginProcessScreen();
              },
            );
          }
          // Loading.
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
