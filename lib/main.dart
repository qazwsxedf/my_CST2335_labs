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
  String _imagePath = "images/question-mark.png"; // String variable to store image path
  final String _correctPassword = "QWERTY123"; // Correct password to compare user input with

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // If user input is same as the correct password, image path is set to the
  //light bulb image, else it is set to the stop sign image.
  void _checkPassword(){
    if(_passwordController.text == _correctPassword){
      setState(() {
        _imagePath = "images/idea.png";
      });
    } else {
      setState(() {
        _imagePath = "images/stop.png";
      });
    }

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
                hintText: "Login",
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
            ElevatedButton(onPressed: _checkPassword, child: Text("Login")),
            // displays the image based on what is stored in _imagePath variable
            Image.asset(_imagePath, width: 300, height:300),
          ],
        ),
      ),

    );
  }
}
