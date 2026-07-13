class AppUser {
  AppUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.username,
    required this.avatar,
    required this.contactId,
    required this.roles,
    required this.permissions,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json['id']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        fullName: json['fullName']?.toString() ?? '',
        username: json['username']?.toString() ?? '',
        avatar: json['avatar']?.toString(),
        contactId: json['contactId']?.toString() ?? '',
        roles: List<String>.from(json['roles'] ?? const []),
        permissions: List<String>.from(json['permissions'] ?? const []),
      );

  final String id;
  final String email;
  final String fullName;
  final String username;
  final String? avatar;
  final String contactId;
  final List<String> roles;
  final List<String> permissions;

  bool get isStudent => roles.contains('STUDENT');

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'fullName': fullName,
        'username': username,
        'avatar': avatar,
        'contactId': contactId,
        'roles': roles,
        'permissions': permissions,
      };
}
