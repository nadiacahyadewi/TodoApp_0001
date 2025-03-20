import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pemilih tanggal
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tanggal Tugas:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _selectedDate == null
                                  ? 'Pilih tanggal'
                                  : DateFormat('dd-MM-yyyy HH:mm').format(_selectedDate!),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today, color: Colors.blue),
                        onPressed: () {
                          BottomPicker.dateTime(
                            pickerTitle: const Text(
                              'Pilih Tanggal & Waktu',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            onChange: (date) {
                              setState(() {
                                _selectedDate = date;
                              });
                            },
                            minDateTime: DateTime.now(),
                            maxDateTime: DateTime.now().add(const Duration(days: 365)),
                            initialDateTime: DateTime.now(),
                            gradientColors: const [Colors.blue, Colors.blue],
                          ).show(context);
                        },
                      ), 
                    ],
                  ),
                   //Error jika tanggal belum di pilih
                  if (_isSubmitted && _selectedDate == null)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        'Harap pilih tanggal',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),

                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nama Tugas',
                            hintText: 'Masukkan nama tugas',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Harap isi nama tugas';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(width: 16),

                      SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          onPressed: addTask,
                          child: Text('Tambah'),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}