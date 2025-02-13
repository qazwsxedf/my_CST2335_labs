import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {

  final String username;
  const ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late EncryptedSharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    prefs = EncryptedSharedPreferences();
    _loadData();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _loadData() async {
    _firstNameController.text = await prefs.getString('firstName') ?? '';
    _lastNameController.text = await prefs.getString('lastName') ?? '';
    _phoneNumberController.text = await prefs.getString('phoneNumber') ?? '';
    _emailController.text = await prefs.getString('email') ?? '';
  }

  void _saveData() async {
    await prefs.setString('firstName', _firstNameController.text);
    await prefs.setString('lastName', _lastNameController.text);
    await prefs.setString('phoneNumber', _phoneNumberController.text);
    await prefs.setString('email', _emailController.text);
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Error"),
          content: Text("Could not launch $url"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome Back ${widget.username}"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body:  Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    hintText: "First Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                    border: OutlineInputBorder()
                  ),
                ),
                Row(
                  children: [
                    Flexible(child: TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        border: OutlineInputBorder(),
                      ),

                    ),
                    ),
                    ElevatedButton(onPressed: () {
                      _launchUrl("tel:${_phoneNumberController.text}");
                    }, child: Icon(Icons.phone),
                    ),
                    ElevatedButton(onPressed: () {
                      _launchUrl("sms:${_phoneNumberController.text}");
                    }, child: Icon(Icons.sms),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ),
                    ElevatedButton(onPressed: () {
                      _launchUrl('mailto:${_emailController.text}');
                    }, child: Icon(Icons.mail),
                    ),
                  ],
                ),
                ElevatedButton(onPressed: _saveData, child: const Text("Save"))
              ]
          ),



        )); //Use a Scaffold to layout a page with an AppBar and main body region
  }

  
}