import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WspButton extends StatelessWidget {
  const WspButton({Key key}) : super(key: key);
  static const String _url = 'https://wa.me/542966402727';
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await canLaunch(_url) ? await launch(_url) : print('Could not launch WhatsApp');
      },
      child: const FaIcon(FontAwesomeIcons.whatsapp),
      heroTag: 'wsp',
      backgroundColor: const Color(0xFF00BB2D),
    );
  }
}
