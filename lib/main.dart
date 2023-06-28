import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 89, 148, 225), size: 15),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Welcome'),
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
  double scale = 1;
  double x = 0;
  double y = 0;

  final Color? loc = Color.fromARGB(255, 102, 173, 232);

  final TransformationController _transformationController =
      TransformationController();

  bool _heightLimited(double width, double height) {
    if (width / height < 780 / 720) {
      return false;
    } else {
      return true;
    }
  }

  double _getLeft(double left, double width, double height) {
    if (!_heightLimited(width, height)) {
      return (left * width) / 780;
    } else {
      var actualW = (height * 780) / 720;
      return ((left * actualW) / 780) + (width - actualW) / 2;
    }
  }

  double _getTop(double top, double width, double height) {
    if (_heightLimited(width, height)) {
      return (top * height) / 720;
    } else {
      var actualH = (width * 720) / 780;
      return ((top * actualH) / 720) + (height - actualH) / 2;
    }
  }

  Widget Place(double left, double top, String title, String desc, Icon icon) {
    return Positioned(
      left: _getLeft(left, MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      top: _getTop(top, MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      child: IconButton(
        icon: icon,
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: SizedBox(
              width: 300,
              child: Text(desc),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          key: _scaffoldState,
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: FloatingActionButton(
            onPressed: () => _scaffoldState.currentState?.openDrawer(),
            hoverColor: Colors.blue.shade300,
            tooltip: 'Menu',
            child: const Icon(Icons.menu),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  title: const Text('Switch floor'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text('Change language'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text('Search for location'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
          body: Center(
            child: InteractiveViewer(
              transformationController: _transformationController,
              onInteractionEnd: (details) {
                scale = _transformationController.value.getMaxScaleOnAxis();
              },
              maxScale: 5,
              child: Stack(
                children: [
                  //Image.asset('build/flutter_assets/images/map-drawn.png',
                  //    fit: BoxFit.contain),
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'build/flutter_assets/images/map-drawn.png'))),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Container();
                    }),
                  ),
                  Place(
                      300,
                      470,
                      'Main Building',
                      'Classes numbered 100 will be on the first floor here, and 200 on the second floor.',
                      const Icon(Icons.home_filled,
                          color: Colors.black, size: 24.0)),
                  Place(
                      530,
                      470,
                      'Freshman Mods',
                      'Classes numbered 175 to 189. This is where freshman English and History classes are located.',
                      const Icon(Icons.home_filled,
                          color: Colors.black, size: 24.0)),
                  Place(
                      250,
                      220,
                      'Science Building',
                      'Classes numbered 300 will be on the first floor here, and 400 on the second floor.',
                      const Icon(Icons.home_filled,
                          color: Colors.black, size: 24.0)),
                  Place(
                      250,
                      170,
                      'Science Mods',
                      'Classes numbered 3** to 3**. Come for the pretty octopus mural, leave cause it\'s smelly.',
                      const Icon(Icons.home_filled,
                          color: Colors.black, size: 24.0)),
                  Place(
                      420,
                      170,
                      'World Language Building',
                      'Classes numbered 500 will be on the first floor here, and 600 on the second floor.\nThis is also where the Health dept. is located.',
                      const Icon(Icons.home_filled,
                          color: Colors.black, size: 24.0)),
                  Place(
                      130,
                      110,
                      'Math Building',
                      'Classes numbered 700 will be on the first floor here, and 800 on the second floor.',
                      const Icon(Icons.home_filled,
                          color: Colors.black, size: 24.0)),
                  Place(
                      600,
                      280,
                      'Waltham St. Drop Off',
                      'Waltham St. loop to be dropped off or picked up. Parking lot is teachers-only.',
                      const Icon(Icons.directions_car,
                          color: Colors.grey, size: 24.0)),
                  Place(
                      360,
                      580,
                      'Worthen St. Drop Off',
                      'Worthen St. loop to be dropped off or picked up. This is also where schoolbuses drop off and pick up students. Limited Senior parking here. AVOID this area if you\'re getting dropped off in the morning; it\'s a mess.',
                      const Icon(Icons.directions_bus,
                          color: Colors.grey, size: 24.0)),
                  Place(
                      320,
                      30,
                      'Park St. Drop Off',
                      'Park St. loop to be dropped off or picked up. Can be busy in the mornings.',
                      const Icon(Icons.directions_car,
                          color: Colors.grey, size: 24.0)),
                  Place(
                      375,
                      270,
                      'THE QUAD',
                      'Great place to hang out between classes, during lunch, or before/after school. Location of Activities Fair, Lex Rise Above Day, and post-finals relaxing activities (dunk tank!).',
                      const Icon(Icons.star)),
                  Place(
                      450,
                      270,
                      'Music rooms',
                      'Location for some band and orchestra classes!',
                      const Icon(Icons.music_note)),
                  Place(
                      490,
                      300,
                      'Commons 2',
                      'Variety of food, including sandwiches, burgers, and a salad bar.',
                      const Icon(Icons.restaurant)),
                  Place(
                      420,
                      290,
                      'Outside Commons 2',
                      'Good place to eat lunch, especially when the tents are up in warmer months.',
                      const Icon(Icons.place)),
                  Place(
                      480,
                      400,
                      'Commons 1',
                      'Variety of food, including world market items, rice bowls/nacho bowls, a salad bar, and snacks.',
                      const Icon(Icons.restaurant)),
                  Place(
                      500,
                      430,
                      'Outside Commons 1',
                      'Good place to eat lunch, especially when the tents are up in warmer months.',
                      const Icon(Icons.place)),
                  Place(
                      350,
                      335,
                      'Main Office',
                      'Directly to the right of the quad entrance. Go here if you have questions about attendance, your dean, etc.',
                      const Icon(Icons.place)),
                  Place(
                      350,
                      350,
                      'Nurses\' Office',
                      'Just past the quad entrance, in a small hallway to the right. You need a pass to come here during class.',
                      const Icon(Icons.medical_information)),
                  Place(
                      335,
                      400,
                      'Gymnasium',
                      'Go to the locker rooms first to drop off your backpack before gym class.',
                      const Icon(Icons.sports_basketball)),
                  Place(
                      305,
                      410,
                      'Boys\' locker room',
                      'To the left of the main entrace, past the bathrooms. You can also find the team rooms (for highschool sports) here, and showers/changing stalls',
                      const Icon(Icons.place)),
                  Place(
                      150,
                      500,
                      'Field House',
                      'This is the field house, where your gym class may meet. Always go to the locker room first to confirm where your class is! The field house has court, track, and workout area.',
                      const Icon(Icons.place)),
                  Place(
                      270,
                      350,
                      'IDLC',
                      'LHS\'s main lecture hall, also called the Science Lecture Hall (SLH). Classes may be here if your teacher is absent and LHS couldn\'t find a substitute.',
                      const Icon(Icons.place)),
                ],
              ),
            ),
          ));
    });
  }
}
