// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<void> _login(
      BuildContext context, String email, String password) async {
    // Endpoint URL API login (sesuaikan dengan URL Anda)
    final url = 'http://10.0.2.2/owari/signup.php';

    try {
      // Membuat permintaan POST ke API login dengan data email dan password
      final response = await http.post(Uri.parse(url), body: {
        'email': email,
        'password': password,
      });

      // Memeriksa status kode respons
      if (response.statusCode == 200) {
        // Parsing response JSON
        final data = jsonDecode(response.body);

        // Memeriksa status dari response
        if (data['status'] == 'success') {
          // Login berhasil, arahkan ke halaman home
          Navigator.pushNamed(context, '/home');
        } else {
          // Login gagal, tampilkan pesan error
          final errorMessage = data['message'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      } else {
        // Gagal terhubung ke server, tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to connect to the server')),
        );
      }
    } catch (error) {
      // Terjadi kesalahan, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset('assets/logo.png', width: 150, height: 150),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Selamat Datang! Senang Melihat Anda Lagi!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 20), //membuat GAP
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility),
                ),
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                _login(context, email, password);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(
                  MediaQuery.of(context).size.width *
                      0.9, // 70% dari lebar screen
                  46.0, // Tinggi tombol
                ),
              ),
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Belum punya akun? '),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
