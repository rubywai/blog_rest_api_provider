import 'package:blog_rest_api_provider/data/model/blog_upload_response.dart';

abstract class UploadUIState{}
class UploadFormState extends UploadUIState{}
class UploadUILoading extends UploadUIState{
  final double progress;
  UploadUILoading(this.progress);
}
class UploadUiSuccess extends UploadUIState{
  final BlogUploadResponse blogUploadResponse;
  UploadUiSuccess(this.blogUploadResponse);
}
class UploadUiFailed extends UploadUIState{
  final String errorMessage;
  UploadUiFailed(this.errorMessage);
}

