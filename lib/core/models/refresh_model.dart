class RefreshModel {
  final String token;
  final int expire;

  RefreshModel({required this.token, required this.expire});

  factory RefreshModel.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'];
    return RefreshModel(
      token: payload['access_token'],
      expire: payload['expire'],
    );
  }
}