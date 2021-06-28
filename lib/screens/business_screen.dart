import 'package:atsa/models/Business.dart';
import 'package:atsa/provider/user_provider.dart';
import 'package:atsa/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'credential_screen.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Text(
                'Descuentos para vos',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
              ),
            ),
            FutureBuilder(
              future: Provider.of<UserProvider>(context, listen: false).getBusiness(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<UserProvider>(
                    builder: (BuildContext _, UserProvider userProvider, Widget __) {
                      return Column(
                        children: userProvider.business.map((business) {
                          return _card(
                            business: business,
                            context: context,
                          );
                        }).toList(),
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CredentialScreen(),
          ),
        ),
        label: Text('Ver mi credencial'),
      ),
    );
  }

  Widget _card({
    @required Business business,
    @required BuildContext context,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(business: business),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 31,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(business.image),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      business.name,
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4, top: 3),
                      child: Text(
                        business.type,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: Colors.black45,
                        ),
                        Expanded(
                          child: Text(
                            business.address,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text('Hasta', style: TextStyle(letterSpacing: 2, color: Colors.grey)),
                  Text(business.discount, style: TextStyle(fontSize: 26)),
                  Text('OFF', style: TextStyle(letterSpacing: 2, color: Colors.grey)),
                ],
              ),
              Icon(Icons.navigate_next, color: Colors.blue)
            ],
          ),
        ),
      ),
    );
  }
}
