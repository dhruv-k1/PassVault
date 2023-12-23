class UserKey {
  final String id;
  final String title;
  final String username;
  final String password;
  final String? email;

  const UserKey({
  required this.id,
  required this.username,
  required this.password,
  required this.title,
  this.email
}
);
 
}