import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_manager.dart';

class AddUserPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prodiController = TextEditingController();

  void _saveUser(BuildContext context) async {
    final apiManager = Provider.of<ApiManager>(context, listen: false);

    final name = _nameController.text;
    final prodi = _prodiController.text;

    try {
      await apiManager.addUser(name, prodi); // Fungsi yang akan kita buat di ApiManager
      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah menyimpan data
    } catch (e) {
      print('Failed to save user. Error: $e');
      // Handle error saving user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Mahasiswa Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _prodiController,
              decoration: InputDecoration(labelText: 'Program Studi'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _saveUser(context),
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}