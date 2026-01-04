import 'package:blog_app/core/theme/blog_pallete.dart';
import 'package:blog_app/features/blog/data/presentation/widget/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogScreen extends StatefulWidget {
  const AddNewBlogScreen({super.key});

  @override
  State<AddNewBlogScreen> createState() => _AddNewBlogScreenState();
}

class _AddNewBlogScreenState extends State<AddNewBlogScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTitle = [];

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.done_rounded)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DottedBorder(
                options:RectDottedBorderOptions(
                  color: BlogPallete.borderColor,
                  dashPattern: const [10, 4],
                  // strokeCap: StrokeCap.round
                ),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            Icons.folder_open,
                          size: 30,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                        'Select your image',
                         style: TextStyle(
                           fontSize: 15
                         )
                        )
                      ],
                    ),
                  )
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    'Technology',
                    'Recreational',
                    'Lifestyle',
                    'Health'
                  ].map((e) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: (){
                        if(selectedTitle.contains(e)){
                          selectedTitle.remove(e);
                        }
                        else{
                          selectedTitle.add(e);
                        }
                        setState(() {

                        });
                      },
                      child: Chip(
                          label: Text(e),
                        color: selectedTitle.contains(e) ? const WidgetStatePropertyAll(BlogPallete.gradient1) : null,
                        side: selectedTitle.contains(e) ? null : const BorderSide(
                          color: BlogPallete.borderColor,
                        ),
                      ),
                    ),
                  )
                  ).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlogEditor(controller: titleController, hintText: 'Blog Title'),
              const SizedBox(
                height: 10,
              ),
              BlogEditor(controller: contentController, hintText: 'Blog Content'),
            ],
          ),
        ),
      ),
    );
  }
}
