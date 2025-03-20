import 'package:flutter/material.dart';

class TodoappPage extends StatefulWidget {
  const TodoappPage({super.key});

  @override
  State<TodoappPage> createState() => _TodoappPageState();
}

class _TodoappPageState extends State<TodoappPage> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final List<String> tasks = [];
  final List<DateTime> taskDates = [];
  final List<bool> _isChecked = [];
  DateTime? _selectedDate;
  bool _isSubmitted = false;

  // Tambah tugas
  void addTask() {
    setState(() {
      _isSubmitted = true;
    });

    if (!_formKey.currentState!.validate() || _selectedDate == null) {
      return;
    }

    setState(() {
      tasks.add(_nameController.text);
      taskDates.add(_selectedDate!);
      _isChecked.add(false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Tugas berhasil ditambahkan'),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      _nameController.clear();
      _selectedDate = null;
      _isSubmitted = false;

      // Scroll ke tugas terbaru
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Aplikasi Tugas'),
        centerTitle: true,
      ),
    );
  }
}
