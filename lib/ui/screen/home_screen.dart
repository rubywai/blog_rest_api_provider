import 'package:blog_rest_api_provider/data/model/get_all_post_response.dart';
import 'package:blog_rest_api_provider/provider/get_all_posts/get_all_post_state.dart';
import 'package:blog_rest_api_provider/provider/get_all_posts/get_all_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getAllPost(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Api Lessons'),
        centerTitle: true,
      ),
      body: Consumer<GetAllPostNotifier>(
          builder: (_,getAllProvider,__){
            GetAllPostState getAllPostState = getAllProvider.getAllPostState;
            if(getAllPostState is GetAllPostSuccess){
              List<GetAllPostResponse> getAllPostResponseList = getAllPostState.getAllPostList;
              return ListView.builder(
                  itemCount: getAllPostResponseList.length,
                  itemBuilder: (context,position){
                    GetAllPostResponse getAllPostResponse = getAllPostResponseList[position];
                    return Card(
                      child: ListTile(
                        title: Text('${getAllPostResponse.title}'),
                      ),
                    );
                  });
            }
            else if(getAllPostState is GetAllPostFailed){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('OOPs Something wrong'),
                  const Divider(),
                  ElevatedButton(onPressed: (){
                    _getAllPost(context);
                  }, child: const Text('Try Again'))
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
      ),
    );
  }
  void _getAllPost(BuildContext ctx){
    Provider.of<GetAllPostNotifier>(ctx,listen: false).getAllPost();
  }
}
