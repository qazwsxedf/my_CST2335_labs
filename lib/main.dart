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
      home: const MyHomePage(title: 'BROWSE CATEGORIES'),
      debugShowCheckedModeBanner: false,
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



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BROWSE CATERGORIES", style: TextStyle (fontSize: 30.0, fontWeight: FontWeight.bold)),
            Text("Not sure about exactly which recipe you're looking for? Do a search, or dive into out most popular categories.", style: TextStyle (fontSize: 20.0), textAlign: TextAlign.left), //align left
            Text("BY MEAT", style: TextStyle (fontSize: 30.0, fontWeight: FontWeight.bold)), //align centre
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Beef Image with Text Overlay
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/BEEF.jpg'),
                      radius: 50,
                    ),
                    Text(
                      "Beef",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Chicken Image with Text Overlay
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/CHICKEN.jpg'),
                      radius: 50,
                    ),
                    Text(
                      "Chicken",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Pork Image with Text Overlay
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/PORK.jpg'),
                      radius: 50,
                    ),
                    Text(
                      "Pork",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Seafood Image with Text Overlay
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/SEAFOOD.jpg'),
                      radius: 50,
                    ),
                    Text(
                      "Seafood",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text("BY COURSE", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/Main Dishes.jpg'),
                      radius: 50,
                    ),
                    Text("Main Dishes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/Salad.jpg'),
                      radius: 50,
                    ),
                    Text("Salad Recipes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/Side Dishes.jpg'),
                      radius: 50,
                    ),
                    Text("Side Dishes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/Crockpot.jpg'),
                      radius: 50,
                    ),
                    Text("Crockpot", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            Text("BY DESSERT", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/Icecream.jpg'),
                      radius: 50,
                    ),
                    Text("Icecream", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/Brownies.jpg'),
                      radius: 50,
                    ),
                    Text("Brownies", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/Pies.jpg'),
                      radius: 50,
                    ),
                    Text("Pies", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/Cookies.jpg'),
                      radius: 50,
                    ),
                    Text("Cookies", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }


}
