import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram UI',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController controller = ScrollController();
  int numberOfImages = 10;

  @override
  void initState() {
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.offset) {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          numberOfImages += 10;
        });
      }
    });
    super.initState();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        controller: controller,
        itemCount: numberOfImages + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemBuilder: (_, i) {
          if (numberOfImages == i) {
            return const LinearProgressIndicator();
          } else {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                "https://source.unsplash.com/random/?$i",
                fit: BoxFit.cover,
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        iconSize: 16,
        backgroundColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "Add", icon: Icon(Icons.add)),
          BottomNavigationBarItem(label: "Shop", icon: Icon(Icons.shop)),
          BottomNavigationBarItem(label: "Avatar", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
