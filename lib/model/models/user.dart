class UserData{
  final String userId;
  final String email;
  final String password;
  final List<String> cartProductIds;

  UserData({
   required this.password,
   required this.email,
   required this.cartProductIds,
   required this.userId,
  });

  factory UserData.fromFirestore(Map<String, dynamic> firestore) =>
      UserData(
        userId: firestore['user_id'],
        email: firestore['email'] ?? " ",
        password: firestore['password'] ?? " ",
        cartProductIds: firestore['cartItems'] ?? " ",
      );
}