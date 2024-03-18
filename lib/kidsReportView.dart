import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReportKidsViewPage extends StatelessWidget {
  late final Stream<QuerySnapshot> _reportsStream;
  late String sid;

  ReportKidsViewPage({required this.sid}) {
    initializeStreams();
  }

  void initializeStreams() {
    _reportsStream = FirebaseFirestore.instance
        .collection('reports')
        .where('sId', isEqualTo: sid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Report'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _reportsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(child: Text('No report data available'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var document = docs[index].data() as Map<String, dynamic>;
              return _buildReportItem('Report ${index + 1}', document);
            },
          );
        },
      ),
    );
  }

Widget _buildReportItem(String title, Map<String, dynamic> data) {
  // Exclude the 'sId' field from the data
  data.remove('sId');

  return Card(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.entries.map((entry) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(entry.value ?? 'Not provided'),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}
}