import 'dart:io';

import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/reusable/cubits/blog_user/blog_user_cubit.dart';
import 'package:blog_app/core/reusable/widgets/loading.dart';
import 'package:blog_app/core/theme/blog_pallete.dart';
import 'package:blog_app/features/blog/presentation/screens/blog_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/image_picker.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../bloc/blog_bloc.dart';
import '../widgets/blog_editor.dart';


class AddNewBlogScreen extends StatefulWidget {
  const AddNewBlogScreen({super.key});

  @override
  State<AddNewBlogScreen> createState() => _AddNewBlogScreenState();
}

class _AddNewBlogScreenState extends State<AddNewBlogScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTitle = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTitle.isNotEmpty &&
        image != null) {
      final userId =
          (context.read<BlogUserCubit>().state as BlogUserSignedIn).user.id;
      context.read<BlogBloc>().add(
        BlogUpload(
          userId: userId,
          blogTitle: titleController.text.trim(),
          blogContent: contentController.text.trim(),
          image: image!,
          topics: selectedTitle,
        ),
      );
    }
  }
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
                uploadBlog();
              },
              icon: const Icon(Icons.done_rounded)
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state){
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          } else if (state is BlogUploadSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              BlogScreen.route(),
                  (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loading();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                image != null
                ? GestureDetector(
                onTap: selectImage,
                  child: SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                      : GestureDetector(
                  onTap: () {
                    selectImage();
                  },
                  child:
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
                      ),
                  ),
                ),

                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: Constant.topics.map((e) => Padding(
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
      ),
    );
  }
}
