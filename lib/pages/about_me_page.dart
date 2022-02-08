import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: ContactUs(
          logo: const AssetImage("assets/NaserElziadna.jpg"),
          email: 'elzianda10@gmail.com',
          companyName: 'Naser Elzianda',
          phoneNumber: '+972584029927',
          dividerThickness: 2,
          website: 'https://www.nmmsoft.com',
          githubUserName: 'NaserElziadna',
          linkedinURL: 'https://www.linkedin.com/in/naser-hassan-b452411a1/',
          tagLine: 'Full Stack Developer',
          cardColor: Colors.white,
          companyColor: Colors.red,
          taglineColor: Colors.green,
          textColor: Colors.black,
        ),
      ),
    );
  }
}
