class UserProfile {
  final int id;
  final String username;
  final String email;
  final String? firstName;
  final String? lastName;

  UserProfile({
    required this.id,
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
  });

  String get fullName {
    if ((firstName?.isEmpty ?? true) && (lastName?.isEmpty ?? true)) {
      return username;
    }
    return '${firstName ?? ''} ${lastName ?? ''}'.trim();
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: (json['id'] as num?)?.toInt() ?? 0,
      username: (json['username'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      firstName: (json['firstName'] ?? json['name']?['firstname']) as String?,
      lastName: (json['lastName'] ?? json['name']?['lastname']) as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
      };
}
