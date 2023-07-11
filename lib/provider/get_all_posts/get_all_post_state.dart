import '../../data/model/get_all_post_response.dart';

abstract class GetAllPostState{}

class GetAllPostLoading extends GetAllPostState{}
class GetAllPostSuccess extends GetAllPostState{
  final List<GetAllPostResponse> getAllPostList;
  GetAllPostSuccess(this.getAllPostList);
}
class GetAllPostFailed extends GetAllPostState{
  final String errorMessage;
  GetAllPostFailed(this.errorMessage);
}
