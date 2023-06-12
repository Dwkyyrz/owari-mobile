import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Animation/FadeAnimation.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({required Key key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class User {
  final String id;
  final String email;
  final String password;
  final String name;
  // final String phoneNumber;
  // final String address;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    // required this.phoneNumber,
    // required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['nama'],
      // phoneNumber: json['telp'],
      // address: json['alamat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'nama': name,
      // 'telp': phoneNumber,
      // 'alamat': address,
    };
  }
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = true;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  Future<void> login() async {
    String email = emailController.text;
    String password = passwordController.text;
    const url = 'https://owarishop.000webhostapp.com/api/adm/login.php';
    try {
      final response = await http.post(Uri.parse(url), body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          final userData = data['user'];
          final user = User(
            email: email,
            password: password,
            id: userData['id'],
            name: userData['nama'],
            // phoneNumber: userData['telp'],
            // address: userData['alamat'],
          );
          // Simpan sesi login pengguna
          await saveUserSession(user);

          Navigator.pushNamed(context, '/dashboard');
        } else {
          final errorMessage = data['message'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to connect to the server')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  Future<void> saveUserSession(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
    await prefs.setBool('isLoggedIn', true);
  }

  Future<User?> getUserSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString('user');
    if (userString != null) {
      final userMap = jsonDecode(userString);
      return User.fromJson(userMap);
    }
    return null;
  }

  // Fungsi untuk memeriksa apakah pengguna sudah login sebelumnya
  Future<bool> checkUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }

  @override
  void initState() {
    super.initState();

    // Cek apakah pengguna sudah login sebelumnya
    // checkUserLoggedIn().then((isLoggedIn) {
    //   if (isLoggedIn) {
    //     // Jika pengguna sudah login sebelumnya, langsung pindah ke halaman '/userProfile'
    //     Navigator.pushNamed(context, '/home');
    //   }
    // });
  }

//   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                  1,
                  Align(
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      child: Image.asset(
                        'assets/logo.png',
                        width: 250,
                        height: 170,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            // SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(
                            1.5,
                            Text(
                              "ADMIN SIGN IN",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 8,
                                        offset: Offset(0, 0))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 240, 240, 240)))),
                                    child: TextField(
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                        prefixIcon: Icon(Icons.email),
                                        border: InputBorder.none,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 237, 237, 237)))),
                                      child: TextField(
                                        controller: passwordController,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          prefixIcon: Icon(Icons.lock),
                                          suffixIcon: IconButton(
                                            onPressed: togglePasswordVisibility,
                                            icon: isPasswordVisible
                                                ? Icon(Icons.visibility_off)
                                                : Icon(Icons.visibility),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        obscureText: isPasswordVisible,
                                      )),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          1.6,
                          ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: Center(
                                child: Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        FadeAnimation(
                            1.7,
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Bukan Pemilik? '),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/login');
                                      },
                                      child: const Text(
                                        'User Sign Up',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
