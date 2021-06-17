class CommentRequestModel {
  CommentRequestModel({this.comment, this.twittId});

  String comment;
  int twittId;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "comment": comment.trim(),
      "twittId": twittId,
    };
    return map;
  }
}

class CommentResponseModel {
  final int id;
  final String textComment;
  final String nickname;
  final String message;

  CommentResponseModel({
    this.id,
    this.nickname,
    this.textComment,
    this.message,
  });

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) {
    return CommentResponseModel(
      id: json['id'] != null ? json['id'] : -1,
      textComment: json['textComment'] != null
          ? json['textComment']
          : "Что то пошло не так.",
      nickname:
          json['nickname'] != null ? json['nickname'] : "Что то пошло не так.",
      message:
          json['message'] != null ? json['message'] : "Что то пошло не так.",
    );
  }
}
