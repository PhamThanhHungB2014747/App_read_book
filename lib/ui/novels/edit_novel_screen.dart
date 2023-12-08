import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/novel.dart';
import 'novel_manager.dart';
import '../customdialog.dart';

class EditNovelScreen extends StatefulWidget {
  static const routeName = '/edit-novel';
  EditNovelScreen(
    Novel? novel, {
    super.key,
  }) {
    if (novel == null) {
      this.novel = Novel(
        id: null,
        name: '',
        author: '',
        description: '',
        countChapter: 0,
        imageUrl: '',
      );
    } else {
      this.novel = novel;
    }
  }

  late final Novel novel;

  @override
  State<EditNovelScreen> createState() => _EditNovelScreenState();
}

class _EditNovelScreenState extends State<EditNovelScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Novel _editedNovel;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editedNovel = widget.novel;
    _imageUrlController.text = _editedNovel.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
            child: Text(
          'Edit Novel',
          style: TextStyle(color: Color(0xFFF5F5F5)),
        )),
        actions: <Widget>[
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save, color: Color(0xFFF5F5F5)),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    buildTitleField(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildAuthorField(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildCountField(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildDescriptionField(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildImageURLField(),
                    const SizedBox(
                      height: 10,
                    ),
                    buildNovelPreview(),
                  ],
                ),
              ),
            ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedNovel.name,
      decoration: const InputDecoration(
        labelText: 'Name',
        labelStyle: TextStyle(
          color: Color(0xFF6096B4),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFF837E93),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFF6096B4),
          ),
        ),
      ),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedNovel = _editedNovel.copyWith(name: value);
      },
    );
  }

  TextFormField buildAuthorField() {
    return TextFormField(
      initialValue: _editedNovel.author,
      decoration: const InputDecoration(
        labelText: 'Author',
        labelStyle: TextStyle(
          color: Color(0xFF6096B4),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFF837E93),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFF6096B4),
          ),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a author';
        }
        return null;
      },
      onSaved: (value) {
        _editedNovel = _editedNovel.copyWith(author: value);
      },
    );
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final novelsManager = context.read<NovelsManager>();
      if (_editedNovel.id != null) {
        // print(_editedNovel.countChapter);
        await novelsManager.updateNovel(_editedNovel);
      } else {
        await novelsManager.addNovel(_editedNovel);
      }
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong');
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedNovel.description,
      decoration: const InputDecoration(
        labelText: 'Description',
        labelStyle: TextStyle(
          color: Color(0xFF6096B4),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            // width: 0,
            color: Color(0xFF837E93),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFF6096B4),
          ),
        ),
      ),
      maxLines: 2,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
      onSaved: (value) {
        _editedNovel = _editedNovel.copyWith(description: value);
      },
    );
  }

  TextFormField buildCountField() {
    return TextFormField(
      initialValue: _editedNovel.countChapter.toString(),
      decoration: const InputDecoration(
        labelText: 'Chapter',
        labelStyle: TextStyle(
          color: Color(0xFF6096B4),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFF837E93),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFF6096B4),
          ),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a chapter';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        if (int.parse(value) <= 0) {
          return 'Please enter a number greater than zero';
        }
        return null;
      },
      onSaved: (value) {
        // print(int.parse(value!));
        _editedNovel =
            _editedNovel.copyWith(countChapter: int.tryParse(value!));
        print(_editedNovel.countChapter);
      },
    );
  }

  Widget buildNovelPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 377,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageUrlController.text.isEmpty
              ? const Text(
                  ' Enter a URL',
                  style: TextStyle(
                    color: Color(0xFF6096B4),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : FittedBox(
                  child: Image.network(
                    width: 200,
                    height: 150,
                    _imageUrlController.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ],
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Image URL',
        labelStyle: TextStyle(
          color: Color(0xFF6096B4),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            // width: 0,
            color: Color(0xFF837E93),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFF6096B4),
          ),
        ),
      ),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an image URL';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL';
        }
        return null;
      },
      onSaved: (value) {
        _editedNovel = _editedNovel.copyWith(imageUrl: value);
      },
    );
  }
}
