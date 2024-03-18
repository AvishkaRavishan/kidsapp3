import 'package:flutter/material.dart';

class KidsCheckssPage extends StatelessWidget {
  final List<KidData> kidsData = [
    KidData(name: 'Adam', imageUrl: "lib/assets/Ellipse 8.png"),
    KidData(name: 'Jude', imageUrl:  "lib/assets/Ellipse 8.png"),
    KidData(name: 'Anne', imageUrl: 'url_to_kid3_image'),
    // Add more kids data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check In / Out'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bright Sparkle ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Select Kid',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: (kidsData.length / 4).ceil(),
              itemBuilder: (context, rowIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (indexInRow) {
                    final kidIndex = rowIndex * 4 + indexInRow;
                    if (kidIndex < kidsData.length) {
                      return KidProfile(
                        name: kidsData[kidIndex].name,
                        imageUrl: kidsData[kidIndex].imageUrl,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportViewPage(
                                kidName: kidsData[kidIndex].name,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return SizedBox(width: 60, height: 60);
                    }
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class KidData {
  final String name;
  final String imageUrl;

  KidData({required this.name, required this.imageUrl});
}

class KidProfile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  const KidProfile({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageUrl),
          ),
          SizedBox(height: 8),
          Text(name),
        ],
      ),
    );
  }
}

class ReportViewPage extends StatelessWidget {
  final String kidName;

  ReportViewPage({required this.kidName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report for $kidName'),
      ),
      body: Center(
        child: Text('report content here for $kidName'),
      ),
    );
  }
}
