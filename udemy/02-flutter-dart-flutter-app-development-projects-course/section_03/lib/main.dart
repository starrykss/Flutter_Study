import 'package:flutter/material.dart';
import 'package:section_03/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          indicatorColor: Colors.transparent,
          controller: tabController,
          tabs: [
            Tab(
              icon: Icon(
                Icons.more,
                color: Colors.purple.withValues(
                  alpha: 0.3,
                ),
                size: 30,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.play_arrow,
                color: Colors.purple.withValues(
                  alpha: 0.3,
                ),
                size: 30,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.navigation,
                color: Colors.purple.withValues(
                  alpha: 0.3,
                ),
                size: 30,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.supervised_user_circle,
                color: Colors.purple.withValues(
                  alpha: 0.3,
                ),
                size: 30,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.camera_alt,
              color: Colors.deepPurple.shade500,
              size: 36,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Fashion Design',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            child: ListView(
              padding: EdgeInsets.all(12),
              scrollDirection: Axis.horizontal,
              children: [
                listElement(
                  'assets/images/model-1.jpg',
                  'assets/images/chanellogo.jpg',
                ),
                SizedBox(
                  width: 15,
                ),
                listElement(
                  'assets/images/model-2.jpg',
                  'assets/images/chanellogo.jpg',
                ),
                SizedBox(
                  width: 15,
                ),
                listElement(
                  'assets/images/model-3.jpg',
                  'assets/images/chanellogo.jpg',
                ),
                SizedBox(
                  width: 15,
                ),
                listElement(
                  'assets/images/model-4.jpg',
                  'assets/images/chanellogo.jpg',
                ),
                listElement(
                  'assets/images/model-1.jpg',
                  'assets/images/chanellogo.jpg',
                ),
                SizedBox(
                  width: 15,
                ),
                listElement(
                  'assets/images/model-2.jpg',
                  'assets/images/chanellogo.jpg',
                ),
                SizedBox(
                  width: 15,
                ),
                listElement(
                  'assets/images/model-3.jpg',
                  'assets/images/chanellogo.jpg',
                ),
                SizedBox(
                  width: 15,
                ),
                listElement(
                  'assets/images/model-4.jpg',
                  'assets/images/chanellogo.jpg',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 5,
              child: Container(
                width: double.infinity,
                height: 550,
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/model-1.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Daisy',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'A few mins ago',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                  color: Colors.deepPurple.shade300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 130,
                        ),
                        Icon(
                          Icons.more_vert,
                          color: Colors.deepPurple,
                          size: 24,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugiat nesciunt quas quos, magni quisquam repellendus dolores nulla perspiciatis eius architecto porro. Repellat alias vero ex odit ducimus repellendus magni optio!',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    img: 'assets/images/big-1.jpg',
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'assets/images/big-1.jpg',
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/big-1.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                        img: 'assets/images/big-2.jpg',
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: "assets/images/big-2.jpg",
                                  child: Container(
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/big-2.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                        img: 'assets/images/big-3.jpg',
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: 'assets/images/big-3.jpg',
                                  child: Container(
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/big-3.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.purple.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '# Lorem Ipsum',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 25,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.purple.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '# Lorem ',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.replay,
                          color: Colors.purple.withValues(
                            alpha: 0.3,
                          ),
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '2.1 k',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.comment,
                          color: Colors.purple.withValues(
                            alpha: 0.3,
                          ),
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '100',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.red.shade800,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '3 k',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 리스트 아이템
  Widget listElement(String imagePath, String logoPath) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              top: 50,
              left: 40,
              child: Container(
                padding: EdgeInsets.all(12),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(logoPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          height: 25,
          width: 85,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade600,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Follow',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
