import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';

class UserActivitiesScreen extends StatelessWidget {
  final String userId;

  UserActivitiesScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Activities'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('activities')
            .where('user', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading indicator
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error handling
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No activities found for this user.'),
            ); // No activities found
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              final videoUrl = document['videoUrl'];
              final imageUrl = document['imageUrl'];

              if (videoUrl != null) {
                return _buildVideoItem(videoUrl);
              } else if (imageUrl != null) {
                return _buildImageItem(imageUrl);
              } else {
                return SizedBox(); // Return an empty widget if neither video nor image URL is available
              }
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildVideoItem(String videoUrl) {
    return ListTile(
      title: Text('Activity Video'),
      leading: FutureBuilder(
        future: VideoPlayerController.network(videoUrl).initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Placeholder while video loads
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            try {
              final controller = VideoPlayerController.network(videoUrl);
              return AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              );
            } catch (e) {
              return Text('Error playing video: $e');
            }
          } else {
            return SizedBox(); // Return empty widget if still loading
          }
        },
      ),
      onTap: () {
        // Handle tap, e.g., navigate to a detail screen
      },
    );
  }

  Widget _buildImageItem(String imageUrl) {
    return ListTile(
      title: Text('Activity Image'),
      leading: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) =>
            CircularProgressIndicator(), // Placeholder while image loads
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      onTap: () {
        // Handle tap, e.g., navigate to a detail screen
      },
    );
  }
}