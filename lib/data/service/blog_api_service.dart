import 'package:blog_rest_api_provider/data/model/blog_upload_response.dart';
import 'package:blog_rest_api_provider/data/model/get_all_post_response.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';


import '../model/get_one_post_response.dart';

class BlogApiService {
  static const String baseUrl = 'http://rubylearner.com:5000/';
  late Dio dio;

  BlogApiService() {
    dio = Dio();
    dio.interceptors.add(DioCacheManager(
      CacheConfig(baseUrl: baseUrl)
    ).interceptor);
  }

  Future<List<GetAllPostResponse>> getAllPosts() async {
    final postListResponse = await dio.get("${baseUrl}posts",
    options: buildCacheOptions(const Duration(days: 7)));
    final postList = (postListResponse.data as List).map((e) {
      return GetAllPostResponse.fromJson(e);
    }).toList();
    return postList;
  }

  Future<GetOnePostResponse> getOnePost(int id) async {
    final postResponse = await dio.get('${baseUrl}post?id=$id',
    options: buildCacheOptions(const Duration(days: 7)));
    final postList = (postResponse.data as List);
    final post = GetOnePostResponse.fromJson(postList[0]);
    return post;
  }

  Future<BlogUploadResponse> uploadPost(
      {required String title,
      required String body,
      required FormData? data,
      required Function(int,int) sendProgress}) async {
    final uploadResponse =
        await dio.post('${baseUrl}post?title=$title&body=$body', data: data,
        onSendProgress: sendProgress);
    return BlogUploadResponse.fromJson(uploadResponse.data);
  }
}
