import 'package:atsa/models/business.dart';
import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'credential_screen.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 60),
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Text(
                'Descuentos para vos',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
              ),
            ),
            FutureBuilder<void>(
              future: Provider.of<UserProvider>(context, listen: false).getBusiness(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<UserProvider>(
                    builder: (BuildContext _, UserProvider userProvider, Widget __) {
                      return Column(
                        children: userProvider.business.map((Business business) {
                          return _card(
                            business: business,
                            context: context,
                          );
                        }).toList(),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (_) => const CredentialScreen(),
          ),
        ),
        label: const Text('Ver mi credencial'),
      ),
    );
  }

  Widget _card({
    @required Business business,
    @required BuildContext context,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: InkWell(
        onTap: () => Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (_) => DetailsScreen(business: business),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 31,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(business.image),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      business.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4, top: 3),
                      child: Text(
                        business.type,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: Colors.black45,
                        ),
                        Expanded(
                          child: Text(
                            business.address,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black45),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  const Text(
                    'Hasta',
                    style: TextStyle(letterSpacing: 2, color: Colors.grey),
                  ),
                  Text(business.discount, style: const TextStyle(fontSize: 26)),
                  const Text(
                    'OFF',
                    style: TextStyle(letterSpacing: 2, color: Colors.grey),
                  ),
                ],
              ),
              const Icon(Icons.navigate_next, color: Colors.blue)
            ],
          ),
        ),
      ),
    );
  }
}
