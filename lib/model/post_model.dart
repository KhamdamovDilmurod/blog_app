import 'dart:convert';

class PostModel {
  final int id;
  final String name;
  final String color;
  final int year;
  final String pantone_value;


  PostModel({
    required this.id,
    required this.name,
    required this.color,
    required this.year,
    required this.pantone_value,
  });

  // Factory constructor to create a UserModel from JSON
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      year: json['year'],
      pantone_value: json['pantone_value'],
    );
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'year': year,
      'pantone_value': pantone_value,
    };
  }

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
