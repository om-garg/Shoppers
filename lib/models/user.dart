class User{
  final String userId;
  final String email;
  final String password;
  final List<String> cartProductIds;

  User({
   required this.password,
   required this.email,
   required this.cartProductIds,
   required this.userId
  });
}