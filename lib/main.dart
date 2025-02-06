import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  late TextEditingController _loginController; // controller for login field
  late TextEditingController _passwordController; // controller for password field
  late EncryptedSharedPreferences prefs;
  late SnackBar snackBar;

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

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Save Login Credentials"),
        content: const Text("Would you save your login name and password for next time?"),
        actions: [
          TextButton(onPressed: () async {
            String username = _loginController.text.isEmpty ? '' : _loginController.text;
            String password = _passwordController.text.isEmpty ? '' : _passwordController.text;

            await prefs.setString('username', username);
            await prefs.setString('password', password);
            Navigator.pop(context);
          }, child: Text("Yes")),
          TextButton(onPressed: () async {
            await prefs.remove('username');
            await prefs.remove('password');
            Navigator.pop(context);
          }, child: Text("No"))
        ],
      ),
    );
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
              decoration: InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder(),
              ),
            ),

            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            // on button press, the _checkPassword function is called
            ElevatedButton(onPressed: _showAlertDialog, child: Text("Login")),
          ],
        ),
      ),

    );
  }
}
