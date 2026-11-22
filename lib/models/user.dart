// MODUL III - Model User + data dummy untuk login

class User {
  final String username;
  final String password;

  const User({required this.username, required this.password});
}

const List<User> dummyUsers = [
  User(username: 'admin', password: 'admin123'),
  User(username: 'trainer', password: 'pokemon'),
];
