//ignore unused import
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/feed_screen.dart';
import 'package:instagram_flutter/screens/post_list.dart';

const webScreenSize=600;



var homeScreenItems=[
            const FeedScreen(),
            const Center(child: Text('Search')),
            const Center(child: PostList()),
            const Center(child: Text('notification')),
            const Center(child: Text('Profile')),

];