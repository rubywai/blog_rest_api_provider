import 'package:blog_rest_api_provider/data/model/get_one_post_response.dart';
import 'package:blog_rest_api_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_provider/provider/get_complet_post/get_complete_post_notifier.dart';
import 'package:blog_rest_api_provider/provider/get_complet_post/get_complete_post_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogPostDetailScreen extends StatefulWidget {
  const BlogPostDetailScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<BlogPostDetailScreen> createState() => _BlogPostDetailScreenState();
}

class _BlogPostDetailScreenState extends State<BlogPostDetailScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getBlogDetail(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Consumer<GetCompletePostNotifier>(
        builder: (_,getCompletePostNotifier,__){
           GetCompletePostState getCompletePostState = getCompletePostNotifier.getCompletePostState;
           if(getCompletePostState is GetCompletePostSuccess){
             GetOnePostResponse getOnePostResponse = getCompletePostState.getOnePostResponse;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(getOnePostResponse.body ?? ''),
                      const Divider(),
                      if(getOnePostResponse.photo != null)
                      Image.network('${BlogApiService.baseUrl}${getOnePostResponse.photo}')
                    ],
                  ),
                ),
              );
           }
           else if(getCompletePostState is GetCompletePostFailed){
              return Column(
                children: [
                  Text(getCompletePostState.errorMessage),
                  const Divider(),
                  ElevatedButton(onPressed: (){
                    _getBlogDetail(widget.id);
                  }, child: const Text('Try Again'))
                ],
              );
           }
           return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
  void _getBlogDetail(int id){
    Provider.of<GetCompletePostNotifier>(context,listen: false)
        .getCompletePost(id: widget.id);
  }
}
