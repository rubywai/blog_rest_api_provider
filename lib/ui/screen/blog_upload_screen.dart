
import 'dart:io';

import 'package:blog_rest_api_provider/provider/upload_post/blog_upload_provider.dart';
import 'package:blog_rest_api_provider/provider/upload_post/upload_ui_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
//logging (http logging)
class BlogUploadScreen extends StatefulWidget {
  const BlogUploadScreen({Key? key}) : super(key: key);

  @override
  State<BlogUploadScreen> createState() => _BlogUploadScreenState();
}

class _BlogUploadScreenState extends State<BlogUploadScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Screen'),
        centerTitle: true,
      ),
      body: Consumer<BlogUploadNotifier>(
        builder: (_,blogUploadNotifier,__){
          UploadUIState uploadUIState = blogUploadNotifier.uploadUIState;
          if(uploadUIState is UploadUILoading){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text('Uploading please wait,... ${uploadUIState.progress} %'),
                const Divider(),
                LinearProgressIndicator(
                  value : uploadUIState.progress
                ),
              ],
            );
          }
          else if(uploadUIState is UploadUiSuccess){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(uploadUIState.blogUploadResponse.result ?? ''),
                const Divider(),
                ElevatedButton(onPressed: (){
                   Navigator.pop(context,'success');
                   blogUploadNotifier.uploadUIState = UploadFormState();
                }, child: const Text('Ok'))
              ],
            );
          }
          else if(uploadUIState is UploadUiFailed){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(uploadUIState.errorMessage),
                const Divider(),
                ElevatedButton(onPressed: (){
                  blogUploadNotifier.tryAgain();
                }, child: const Text('Try again'))
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your blog title',
                      border: OutlineInputBorder()
                    ),
                  ),
                  const Divider(),
                  TextField(
                    minLines: 3,
                    maxLines: 5,
                    controller: _bodyController,
                    decoration: const InputDecoration(
                        labelText: 'Enter your blog content',
                        border: OutlineInputBorder()
                    ),
                  ),
                  const Divider(),
                  FilledButton(
                      onPressed: () async{
                        XFile? file = await  _imagePicker.pickImage(source: ImageSource.gallery);
                        if(file != null) {
                          setState(() {
                          _image = File(file.path);
                        });
                        }

                      },
                      child: const Text('Select Photo')),
                  const Divider(),
                  if(_image != null)
                  Image.file(_image!,height: 200,),
                  ElevatedButton(onPressed: () async{
                    if(_titleController.text.isNotEmpty && _bodyController.text.isNotEmpty){
                      String title = _titleController.text;
                      String body = _bodyController.text;
                      FormData? data;
                      if(_image != null) {
                        data = FormData.fromMap({
                        'photo' : await MultipartFile.fromFile(_image!.path)
                      });
                      }
                      if(mounted) {
                        Provider.of<BlogUploadNotifier>(context,listen: false).upload(title: title, body: body, data: data);
                      }
                    }
                    else{
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Please enter title and content')));
                    }
                  }, child: const Text('Upload'))

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
