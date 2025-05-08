class Provider {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String state;

  Provider({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.state,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: int.parse(json['providerid'].toString()),
      name: json['provider_name'],
      lastName: json['provider_last_name'],
      email: json['provider_mail'],
      state: json['provider_state'],
    );
  }
}
