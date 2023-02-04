//Class to store information about cast member. Data is extracted from a map (json response)

class CastMember {
  final int id;
  final String name;
  final String? profilePath;
  final String? character;
  final String? department;

  CastMember({
    required this.id,
    required this.name,
    this.profilePath,
    this.character,
    required this.department,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    return CastMember(
      id: json['id'],
      name: (json['name'] != null) ? json['name'] : "Name unavailable",
      profilePath: (json['profile_path'] != null) ? json['profile_path'] : "",
      character: (json['character'] != null)
          ? json['character']
          : "Character name unavailable",
      department: (json['known_for_department'] != null)
          ? json['known_for_department']
          : "Department unavailable",
    );
  }
}
