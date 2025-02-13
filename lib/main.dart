import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:lab_2/ProfilePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: "Lab 5 - Login Page"), // Home route
        '/profile': (context) => const ProfilePage(username: ''), // Profile route
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Removed the 'home' property
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  String _imagePath = "images/question-mark.png";
  final String _correctPassword = "QWERTY123";
  late EncryptedSharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    prefs = EncryptedSharedPreferences();
    _loadSavedCredentials();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkPassword() {
    if (_passwordController.text == _correctPassword) {
      setState(() {
        _imagePath = "images/idea.png";
      });
      // Navigate to the ProfilePage using named routes
      Navigator.pushNamed(
        context,
        '/profile',
        arguments: _loginController.text, // Pass the username as an argument
      );
      // Show a Snackbar with a welcome message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Welcome Back ${_loginController.text}"),
        ),
      );
    } else {
      setState(() {
        _imagePath = "images/stop.png";
      });
    }
  }

  void _loadSavedCredentials() async {
    var savedUsername = await prefs.getString('username');
    var savedPassword = await prefs.getString('password');

    if (savedPassword != '' && savedUsername != '') {
      _loginController.text = savedUsername;
      _passwordController.text = savedPassword;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Previous login credentials loaded.'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _loginController.text = '';
                _passwordController.text = '';
              });
            },
          ),
        ),
      );
    }
  }

  Future<void> _showAlertDialog() async{
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Save Login Credentials"),
        content: const Text("Would you save your login name and password for next time?"),
        actions: [
          TextButton(
            onPressed: () async {
              String username = _loginController.text.isEmpty ? '' : _loginController.text;
              String password = _passwordController.text.isEmpty ? '' : _passwordController.text;

              await prefs.setString('username', username);
              await prefs.setString('password', password);
              Navigator.pop(context);
            },
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () async {
              await prefs.remove('username');
              await prefs.remove('password');
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),
        ],
      ),
    );
  }

  void _login() async {
    await _showAlertDialog();
    _checkPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: const Text("Login"),
            ),
            Image.asset(_imagePath, width: 300, height: 300),
          ],
        ),
      ),
    );
  }
}