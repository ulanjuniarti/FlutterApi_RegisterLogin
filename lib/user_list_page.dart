import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_manager.dart';
import 'user_manager.dart';
import 'add_user_page.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<Map<String, dynamic>> _users = [];

  @override
  Widget build(BuildContext context) {
    //provider dari main.dart
    final apiManager = Provider.of<ApiManager>(context);
    final userManager = Provider.of<UserManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('User List Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              userManager.setAuthToken(null);
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  final users = await apiManager.getUsers();
                  setState(() {
                    _users = users;
                  });
                } catch (e) {
                  print('Failed to get users. Error: $e');
                  // Handle user fetching failure
                }
              },
              child: Text('Refresh Users'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUserPage()),
                );
              },
              child: Text('Tambahkan User'),
            ),

            SizedBox(height: 16),
            Text('Users:'),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];
                  return ListTile(
                    title:
                    Text('Nama: ${user['nama']}, Prodi: ${user['prodi']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}