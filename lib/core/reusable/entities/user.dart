class User{
  final String id;
  final String email;
  final String name;
  User({
    required this.id,
    required this.email,
    required this.name,
  });
}

//Core cannot depend on other features but other features can depend on the core