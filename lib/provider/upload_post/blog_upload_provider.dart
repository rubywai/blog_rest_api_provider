import 'package:blog_rest_api_provider/data/model/blog_upload_response.dart';
import 'package:blog_rest_api_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_provider/provider/upload_post/upload_ui_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class BlogUploadNotifier extends ChangeNotifier{
  UploadUIState uploadUIState = UploadFormState();
  final BlogApiService _blogApiService = BlogApiService();
  void upload({required String title, required String body,required FormData? data}) async{
    try{
      uploadUIState = UploadUILoading(0);
      notifyListeners();
      BlogUploadResponse blogUploadResponse = await _blogApiService.uploadPost(title: title, body: body, data: data,
      sendProgress: (int send,int size){
        double progress = ((send/size) * 100);
        uploadUIState = UploadUILoading(progress);
        notifyListeners();
      });
      uploadUIState = UploadUiSuccess(blogUploadResponse);
      notifyListeners();
    }
    catch(e){
      uploadUIState = UploadUiFailed('Something wrong');
      notifyListeners();
    }
  }
  void tryAgain(){
    uploadUIState = UploadFormState();
    notifyListeners();
  }
}