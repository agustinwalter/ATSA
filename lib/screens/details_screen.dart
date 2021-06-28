import 'package:atsa/models/business.dart';
import 'package:atsa/screens/credential_screen.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key key, @required this.business}) : super(key: key);

  final Business business;

  @override
  Widget build(BuildContext context) {
    final double sHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(top: 120),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: sHeight - 140,
                      minWidth: double.infinity,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            business.name,
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(
                            business.type.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.grey,
                              letterSpacing: 2,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Icon(
                                Icons.location_on_outlined,
                                size: 18,
                                color: Colors.blue,
                              ),
                              Expanded(
                                child: Text(
                                  business.address,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (business.details.isNotEmpty) _details()
                        ],
                      ),
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
                    icon: const Icon(Icons.arrow_back_ios_outlined),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
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

  Widget _details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Detalles', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        Text(business.details, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }
}
