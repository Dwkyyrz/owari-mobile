import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String id;
  final String email;
  final String password;
  final String name;
  final String phoneNumber;
  final String address;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['nama'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['telp'],
      address: json['alamat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'nama': name,
      'telp': phoneNumber,
      'alamat': address,
    };
  }
}

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  User? user;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  Future<void> checkUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString('user');
    if (userString != null) {
      final userMap = jsonDecode(userString);
      setState(() {
        user = User.fromJson(userMap);
        _nameController.text = user!.name;
        _emailController.text = user!.email;
        _passwordController.text = user!.password;
        _phoneController.text = user!.phoneNumber;
        _addressController.text = user!.address;
      });
    } else {
      goToLoginPage();
    }
  }

  void goToLoginPage() {
    Navigator.popAndPushNamed(context, '/login');
  }

  Future<void> updateProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString('user');
    if (userString != null) {
      final userMap = jsonDecode(userString);
      final User currentUser = User.fromJson(userMap);

      final updatedUser = User(
        id: currentUser.id,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        phoneNumber: _phoneController.text,
        address: _addressController.text,
      );

      final url =
          'https://owari2.000webhostapp.com/owari/api/update_akun.php'; // Ganti dengan URL API Anda
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['u_id'] = updatedUser.id;
      request.fields['username'] = updatedUser.name;
      request.fields['email'] = updatedUser.email;
      request.fields['password'] = updatedUser.password;
      request.fields['telp'] = updatedUser.phoneNumber;
      request.fields['alamat'] = updatedUser.address;

      var response = await request.send();
      if (response.statusCode == 200) {
        await prefs.setString('user', jsonEncode(updatedUser.toJson()));

        setState(() {
          user = updatedUser;
        });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Profile updated successfully.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  goToProfilePage();
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update profile.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  void goToProfilePage() {
    Navigator.popAndPushNamed(context, '/userProfile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  prefixIcon: Icon(Icons.people),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Nomor HP',
                  prefixIcon: Icon(Icons.phone),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  prefixIcon: Icon(Icons.home),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Update Profile'),
                onPressed: updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
