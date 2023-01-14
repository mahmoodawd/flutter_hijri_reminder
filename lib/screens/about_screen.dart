import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = 'about-screen';
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_icon.png',
              fit: BoxFit.contain,
              height: 150,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Hijri Reminder',
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 26),
              textAlign: TextAlign.center,
            ),
            Text(
              'Reminder app in Hijri',
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'You Can reach us at: ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 16, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                    heroTag: 'gmailBtn',
                    onPressed: () => _launchURLBrowser(
                        'mailto:mahmooodawd@gmail.com?subject=Coming from Hijri reminder app'),
                    child: Icon(FontAwesomeIcons.google)),
                SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                    heroTag: 'inBtn',
                    onPressed: () =>
                        _launchURLBrowser('https://linkedin.com/in/mahmoodawd'),
                    child: Icon(FontAwesomeIcons.linkedinIn)),
                SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                    heroTag: 'phoneBtn',
                    onPressed: () => _launchURLBrowser('tel:+20 114 168 0631'),
                    child: Icon(FontAwesomeIcons.phone)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _launchURLBrowser(String link) async {
    var url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
