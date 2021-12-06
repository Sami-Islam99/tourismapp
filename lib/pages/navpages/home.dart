import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tourismapp/pages/login.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<String> travels = ["Cab", "Train", "Plane", "Bus"];
  List<String> guiders = ["Kareem Dad", "Saif ur Rehman", "Arooj Fatima", "Phola Cheeda"];
  Map<String, String> travelImages = {
    "Cab": "cab.jpg",
    "Train": "train.png",
    "Plane": "plane.png",
    "Bus": "plane.png",
  };
  Map<String, String> guiderImages = {
    "Kareem Dad": "cab.jpg",
    "Saif ur Rehman": "train.png",
    "Arooj Fatima": "plane.png",
    "Phola Cheeda": "plane.png",
  };
  final List<String> _tabs = ["Places", "Hotels", "Restaurants", "Malls"];
  final List<Widget> _tabViews = [
    TabView([1, 2, 3]),
    TabView([1, 2, 3]),
    TabView([1]),
    TabView([1, 3]),
  ];

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: _tabs.length, vsync: this);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        actions: [
          CircleAvatar(backgroundColor: Colors.grey),
          SizedBox(width: 10.0),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(accountName: Text("accountName"), accountEmail: Text("accountEmail")),
            ListTile(
              leading: Icon(FontAwesomeIcons.signOutAlt),
              title: AppText(text: "Logout"),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.offAll(() => LoginPage());
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          //upper Menu bar icon + image
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: AppLargeText(text: "Discover"),
          ),
          SizedBox(height: 20),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding: const EdgeInsets.only(left: 20, right: 20),
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicator: CircleTabIndicator(color: AppColors.primary, radius: 4),
                tabs: _tabs.map((e) => Tab(text: e)).toList(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 300,
            child: TabBarView(controller: _tabController, children: _tabViews),
          ),
          SizedBox(height: 20),
          ExploreSection(title: "Travels", nameImages: travelImages, names: travels),
          SizedBox(height: 20),
          ExploreSection(title: "Guiders", nameImages: guiderImages, names: guiders),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ExploreSection extends StatelessWidget {
  const ExploreSection({
    Key? key,
    required this.nameImages,
    required this.names,
    required this.title,
  }) : super(key: key);

  final Map<String, String> nameImages;
  final List<String> names;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppLargeText(text: "Explore $title", size: 20),
              AppText(text: "See all", color: AppColors.textColor1),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 110,
          width: double.maxFinite,
          margin: const EdgeInsets.only(left: 20),
          child: ListView.builder(
              itemCount: nameImages.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: AssetImage("img/" + nameImages[names[index]]!)))),
                      SizedBox(height: 5),
                      Container(
                        child: AppText(
                          text: names[index],
                          size: 10,
                          color: AppColors.textColor2,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class TabView extends StatelessWidget {
  final List data;

  const TabView(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            margin: const EdgeInsets.only(top: 10, right: 15),
            width: 200,
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                image: DecorationImage(fit: BoxFit.cover, image: NetworkImage("https://picsum.photos/200"))));
      },
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CirclePainter(color: color, radius: radius);
  }
}

class CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(configuration.size!.width / 2 - radius / 2, configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
