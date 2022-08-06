class AccessToken {
  String token;

  AccessToken(
      {required this.token});

  String bearerToken() {
    return "Bearer $token";
  }
}
