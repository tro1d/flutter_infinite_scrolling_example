class Post {
// class Post extends Equatable {
  final int id;
  final String userName;
  final String userImage;
  final String textPost;
  final String imagePost;
  final List<String> likePost;
  final List<String> commentPost;
  final DateTime createAt;

  Post({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.textPost,
    required this.imagePost,
    required this.likePost,
    required this.commentPost,
    required this.createAt,
  });

  // @override
  // List<Object?> get props {
  //   return [id, userName, userImage, textPost, imagePost, likePost, commentPost];
  // }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userImage': userImage,
      'textPost': textPost,
      'imagePost': imagePost,
      'likePost': likePost,
      'commentPost': commentPost,
      'createAt': createAt.toUtc().toIso8601String(),
    };
  }

  factory Post.fromJson(Map<String, dynamic> postJson) {
    return Post(
      id: postJson['id'] ?? 0,
      userName: postJson['userName'] ?? '',
      userImage: postJson['userImage'] ?? '',
      textPost: postJson['textPost'] ?? '',
      imagePost: postJson['imagePost'] ?? '',
      likePost: postJson['likePost'] ?? [],
      commentPost: postJson['commentPost'] ?? [],
      createAt: postJson['createAt'] != null ? DateTime.parse(postJson['createAt']) : DateTime.now(),
    );
  }

  Post copyWith({
    int? id,
    String? userName,
    String? userImage,
    String? textPost,
    String? imagePost,
    List<String>? likePost,
    List<String>? commentPost,
    DateTime? createAt,
  }) {
    return Post(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      textPost: textPost ?? this.textPost,
      imagePost: imagePost ?? this.imagePost,
      likePost: likePost ?? this.likePost,
      commentPost: commentPost ?? this.commentPost,
      createAt: createAt ?? this.createAt,
    );
  }
}
