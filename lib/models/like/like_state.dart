class LikeRequest {
  final String memberId;
  final String postId;
  final String flag;

  LikeRequest({
    required this.memberId,
    required this.postId,
    required this.flag,
  });

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'postId': postId,
      'flag': flag,
    };
  }
}
