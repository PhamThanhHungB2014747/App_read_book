import 'package:flutter/foundation.dart';

class Novel {
  final String? id;
  final String name;
  final String author;
  final String description;
  final String imageUrl;
  final int countChapter;
  final ValueNotifier<bool> _inLibrary;

  Novel({
    this.id,
    required this.name,
    required this.author,
    required this.description,
    required this.countChapter,
    required this.imageUrl,
    inLibrary = false,
  }) : _inLibrary = ValueNotifier(inLibrary);

  set inLibrary(bool newValuve) {
    _inLibrary.value = newValuve;
  }

  bool get inLibrary {
    return _inLibrary.value;
  }

  ValueNotifier<bool> get inLibraryListenable {
    return _inLibrary;
  }

  Novel copyWith({
    String? id,
    String? name,
    String? author,
    String? description,
    int? countChapter,
    String? imageUrl,
    bool? inLibrary,
  }) {
    return Novel(
      id: id ?? this.id,
      name: name ?? this.name,
      author: author ?? this.author,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      countChapter: countChapter ?? this.countChapter,
      inLibrary: inLibrary ?? this.inLibrary,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'author': author,
      'description': description,
      'countChapter': countChapter,
      'imageUrl': imageUrl,
    };
  }

  static Novel fromJson(Map<String, dynamic> json) {
    return Novel(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      description: json['description'],
      countChapter: json['countChapter'],
      imageUrl: json['imageUrl'],
      // inlibrary: json['inlibrary'],
    );
  }
}
