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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}