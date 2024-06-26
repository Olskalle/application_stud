import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/apiService.dart';
import '../models/models.dart';
import '/pages/reg_page.dart'; 
import 'package:flutter_application_1/pages/baza_page.dart';

class LoginPage extends StatelessWidget {
  final ApiService apiService = ApiService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key, Key? key1});

Future<void> _login(BuildContext context) async {
  final String email = _emailController.text.trim();
  final String password = _passwordController.text.trim();

  final loginModel = LoginModel(email: email, password: password);

  try {
    await apiService.login(loginModel);

    // Navigate to home page if login is successful
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BazaPage()),
    );
  } catch (e) {
    // Show error message if login fails
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to login. Please check your credentials.')),
    );
  }
}

  // void _login(BuildContext context) {
    
  //   // // Здесь ваша логика входа
    
  //   // // Временно мы просто переходим на главную страницу после входа
  //   // Navigator.pushReplacement(
  //   //   context,
  //   //   MaterialPageRoute(builder: (context) => const BazaPage()),
  //   // );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: SizedBox(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/fridge.png',
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      const Text(
                        'Fridge',
                        style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _login(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'Авторизоваться',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        // Отправить пользователя на страницу регистрации
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegistrationPage()),
                        );
                      },
                      child: const Text(
                        'Зарегистрироваться',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
