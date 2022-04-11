import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thrifters',
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Thrifters",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark),
            iconSize: 16,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            iconSize: 16,
          ),
        ],
      ),
      body: ListView(
        controller: controller,
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: [
          // Search
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 37, 35, 35),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    width: 0,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          // Categories
          SizedBox(
            height: 25,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (_, i) => Container(
                margin: const EdgeInsets.only(right: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Category$i",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              itemCount: numberOfImages + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemBuilder: (_, i) {
                if (numberOfImages == i) {
                  return Container(
                      padding: const EdgeInsets.all(50),
                      height: 50,
                      child: const CircularProgressIndicator());
                } else {
                  return Image.network(
                    "https://source.unsplash.com/random/?$i",
                    fit: BoxFit.cover,
                  );
                }
              })
        ],
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
