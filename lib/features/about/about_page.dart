import 'package:driveaustralia/widgets/DrivingPage.dart';
import 'package:driveaustralia/widgets/app_bar.dart';
import 'package:driveaustralia/widgets/dkt_space.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url =
    Uri.parse('https://www.linkedin.com/in/subash-khatri-19254b58/');

class AboutDeveloperPage extends StatefulWidget {
  final String? category;
  final String? id;
  final String? lastPath;

  const AboutDeveloperPage({
    Key? key,
    this.category,
    this.lastPath,
    this.id,
  }) : super(key: key);

  @override
  State<AboutDeveloperPage> createState() => _AboutDeveloperPageState();
}

class _AboutDeveloperPageState extends State<AboutDeveloperPage> {
  @override
  Widget build(BuildContext context) {
    return DrivingPage(
      lastpath: widget.lastPath ?? '',
      appBar: appBarBackButton(
        context,
        widget.category ?? '',
        widget.lastPath ?? '',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const DktSpace(
                  height: 25,
                ),
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                      'https://scontent.fsyd4-1.fna.fbcdn.net/v/t39.30808-6/328319185_1353654222098405_6414237067655794310_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=bQ3BmFCkO8wAX9oQ-4Y&_nc_ht=scontent.fsyd4-1.fna&oh=00_AfA1hhuF30ZQ76TX7FLxrO8B11Hj0GqIIxtAi0caoNmRUQ&oe=644DE4EF'),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Subash Khatri',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Flutter (Full Stack) Developer',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const DktSpace(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () async {
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  child: const Text('LinkedIn'),
                ),
                const DktSpace(),
                const Text(
                  'Flutter Developer with more than 3 years of experiences.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.teal,
                  ),
                ),
                const DktSpace(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Subash Khatri is a skilled Flutter developer with over 3+ years of experience developing mobile applications. They have a strong understanding of Flutter and Dart and are able to create efficient, high-quality code that delivers an excellent user experience. Subash has worked on a variety of projects, from simple prototypes to complex, enterprise-level applications. They are passionate about staying up-to-date with the latest technologies and best practices in the field to ensure that their work is always of the highest quality.',
                    textAlign: TextAlign.justify,
                  ),
                ),
                const DktSpace(),
              ]),
        ),
      ),
    );
  }
}
