import 'package:atsa/models/Business.dart';
import 'package:atsa/screens/credential_screen.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Business business;

  const DetailsScreen({Key key, @required this.business}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Stack(
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.only(top: 120),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                    ),
                    Text(
                      business.name,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      business.type.toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: Colors.blue,
                        ),
                        Expanded(
                          child: Text(
                            business.address,
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    if (business.details.isNotEmpty) _details()
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: CircleAvatar(
                  radius: 101,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(business.image),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined),
                onPressed: () => Navigator.pop(context),
              ),
            )
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

  Widget _details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detalles',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8),
        Text(
          business.details,
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
