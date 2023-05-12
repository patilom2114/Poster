import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/add_post_screen.dart';

class PostList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => PostListState();
  const PostList({super.key});

}


class PostListState extends State<PostList>{
  @override
  Widget build(BuildContext context) {
    return

      Center(
      child: IconButton(
        icon: const Icon(
          Icons.upload,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddPostScreen(),
          ));
        },
      ),
    );
  }

}

