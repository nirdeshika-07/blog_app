import 'package:blog_app/features/blog/data/presentation/screens/add_new_blog_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
      builder: (context) => const AddNewBlogScreen()
  );
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Blog App"),
        actions: [
          IconButton(
          onPressed: (){
            Navigator.push(context, BlogScreen.route());
          },
              icon: const Icon(
                CupertinoIcons.add_circled
              )
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
      ),
    );
  }
}
