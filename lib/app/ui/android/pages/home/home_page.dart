import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app6/app/routes/app_pages.dart';
import 'package:flutter_app6/app/ui/android/pages/temp_page.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double screenWidth;
  double screenHeight;
  double _drawerTranslationX;
  double _drawerTranslationY;
  double _drawerTranslationZ;
  double _drawerScaleDown;
  AnimationController _drawerAnimationController;
  Animation _drawerAnimation;
  bool _drawerShowing;
  double _expandedHeightOfAppBar = 250;
  int _currentState = 0;

  List<Widget> _children;
  Widget frontPage;
  Widget samplePage;
  Widget frontPageWithTabs;
  Widget drawerBackgroundPage;
  Widget backPage;

  double _drawerBlurRadius;
  double _drawerBlurSpread;
  double _drawerBorderRadius;

  bool _isInAccurateDirection;

  double _maxSlide = 200.0;

  @override
  void initState() {
    super.initState();
    // this.widget.frontPage.state.drawerIconTapped =this.onDrawerIconTapped;
    _drawerAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _drawerShowing = false;
    _drawerAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: _drawerAnimationController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _drawerAnimationController.dispose();
    super.dispose();
  }

  void _onDrawerIconTapped() {
    _toggleDrawerShowing();
  }

  void _toggleDrawerShowing() {
    if (_drawerShowing) {
      _drawerShowing = false;
      _drawerAnimationController.reverse();
    } else {
      _drawerShowing = true;
      _drawerAnimationController.forward();
    }
  }

  double _interpolate(double num, double begin, double end) {
    return begin + num * (end - begin);
  }

  void _onPageTapped() {
    if (_drawerShowing) {
      _toggleDrawerShowing();
    }
  }

  void _onHomeDrawerPressed(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Home Pressed'),
      ),
    );
  }

  void _onSettingsDrawerPressed(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Settings Pressed'),
      ),
    );
  }

  void _onAboutDrawerPressed(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('About Pressed'),
      ),
    );
  }

  void _onHelpDrawerPressed(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Help Pressed'),
      ),
    );
  }

  void _onTabItemTap(int value) {
    setState(() {
      _currentState = value;
    });
  }

  void _changeStatusAndNavigationBarColors() {
    FlutterStatusbarcolor.setStatusBarColor(
        Colors.transparent); //this change the status bar color to white
    FlutterStatusbarcolor.setNavigationBarColor(Colors.green);
  }

  void _onPageHorizontalDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _drawerAnimationController.isDismissed &&
        details.globalPosition.dx > 5.0;
    bool isDragCloseFromRight = _drawerAnimationController.isCompleted &&
        details.globalPosition.dx >= 5.0;
    _isInAccurateDirection = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onPageHorizontalDragUpdate(DragUpdateDetails details) {
    if (_isInAccurateDirection) {
      double delta = details.primaryDelta / _maxSlide;
      _drawerAnimationController.value += delta;
    }
  }

  void _onPageHorizontalDragEnd(DragEndDetails details) {
    if (_drawerAnimationController.isDismissed ||
        _drawerAnimationController.isCompleted) return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx / screenWidth;
      _drawerAnimationController.fling(velocity: visualVelocity);
      if (details.velocity.pixelsPerSecond.dx > 0) {
        _drawerShowing = true;
      } else {
        _drawerShowing = false;
      }
    } else if (_drawerAnimationController.value <= 0.05) {
      _drawerAnimationController.animateBack(0.0);
      _drawerShowing = false;
    } else {
      _drawerAnimationController.animateTo(1.0);
      _drawerShowing = true;
    }
  }

  Widget drawerMenuButton(IconData icon, String text, int itemIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: FlatButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            children: [
              Padding(
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              Expanded(
                child: Text('$text',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white)),
              ),
            ],
          ),
        ),
        onPressed: () => _onDrawerItemPressed(itemIndex),
        padding: EdgeInsets.zero,
      ),
    );
  }

  _onDrawerItemPressed(int itemIndex) {}

  List<GetPage> _getPages() {
    // return Map.fromIterable(
    //   AppPages.pages.where((page)=> page.name!='/'),
    //   key:(page)=>(page as GetPage).title,
    //   value: (page)=>(page as GetPage).name,
    // );
    return AppPages.pages.where((page) => page.name != '/').toList();
  }

  Widget _getPageCardForListView(int index) {
    var pageList = _getPages();
    if (index >= pageList.length) return null;
    return GestureDetector(
      onTap: () => Get.toNamed(pageList[index].name),
      child: Card(
        elevation: 2,
        child: Container(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Row(
              children: [
                Text(
                  "${index + 1}",
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    "${pageList[index].title}",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: null,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _changeStatusAndNavigationBarColors();

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    _drawerScaleDown = 0.8;
    _drawerTranslationX = screenWidth * 0.6;
    _drawerTranslationY = screenHeight * (1 - _drawerScaleDown) / 2;
    _drawerTranslationZ = 10.0;
    _drawerBlurRadius = 5;
    _drawerBlurSpread = 4;
    _drawerBorderRadius = 10;

    // GlobalKey<MyDrawerPageAnimatedState> drawerPageKey = GlobalKey();
    frontPage = Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Container(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                    ),
                    onPressed: null,
                    iconSize: 30,
                    color: Colors.white,
                    disabledColor: Colors.white,
                  ),
                  IconButton(
                    icon: Icon(Icons.mail_outline),
                    onPressed: null,
                    iconSize: 30,
                    color: Colors.white,
                    disabledColor: Colors.white,
                  ),
                ],
                leading: IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_arrow,
                    progress: _drawerAnimation,
                  ),
                  // icon: IconButton(
                  //   icon: Icon(Icons.list),
                  //   onPressed: _onDrawerIconTapped,
                  // ),
                  onPressed: _onDrawerIconTapped,
                  iconSize: 30,
                ),
                pinned: true,
                floating: true,
                stretch: true,
                expandedHeight: _expandedHeightOfAppBar,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('My Widgets'),
                  // centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  stretchModes: [StretchMode.blurBackground],
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.lerp(Theme.of(context).primaryColor,
                              Colors.black, 0.3),
                          Theme.of(context).primaryColor
                        ],
                      ),
                    ),
                    // child: Placeholder(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  // child: Placeholder(
                  //   fallbackHeight: 50,
                  // ),
                  ),
              SliverList(
                  // itemExtent: 50,
                  delegate: SliverChildBuilderDelegate((context, index) {
                return _getPageCardForListView(index);
              }))
            ],
          ),
        ),
      ],
    );
    samplePage = Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Container(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: [
                  Placeholder(
                    fallbackWidth: 50,
                    color: Colors.lime[800],
                  ),
                  Placeholder(
                    fallbackWidth: 50,
                    color: Colors.red,
                  ),
                  Placeholder(fallbackWidth: 50, color: Colors.amber),
                ],
                leading: IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_arrow,
                    progress: _drawerAnimation,
                  ),
                  // icon: IconButton(
                  //   icon: Icon(Icons.list),
                  //   onPressed: _onDrawerIconTapped,
                  // ),
                  onPressed: _onDrawerIconTapped,
                  iconSize: 30,
                ),
                pinned: true,
                floating: true,
                stretch: true,
                expandedHeight: _expandedHeightOfAppBar,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('My Samples'),
                  // centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  stretchModes: [StretchMode.blurBackground],
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.lerp(Theme.of(context).primaryColor,
                              Colors.black, 0.3),
                          Theme.of(context).primaryColor
                        ],
                      ),
                    ),
                    child: Placeholder(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Placeholder(
                  fallbackHeight: 50,
                ),
              ),
              SliverFixedExtentList(
                  itemExtent: 50,
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Card(
                      elevation: 2,
                      child: Row(
                        children: [Placeholder()],
                      ),
                    );
                  }))
            ],
          ),
        ),
      ],
    );
    _children = [
      frontPage,
      samplePage,
      TempPage(),
    ];
    frontPageWithTabs = Scaffold(
      body: _children[_currentState],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabItemTap,
        currentIndex: _currentState,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets),
            label: 'Widgets',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Samples'),
          BottomNavigationBarItem(
              icon: Icon(Icons.dnd_forwardslash), label: 'Temp'),
        ],
      ),
    );
    drawerBackgroundPage = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          colors: [
            Color.lerp(Theme.of(context).primaryColor, Colors.black, 0.95),
            Color.lerp(Theme.of(context).primaryColor, Colors.brown[800], 0.3),
          ],
        ),
      ),
    );
    backPage = Padding(
      padding: EdgeInsets.fromLTRB(
          8.0, screenHeight * 0.15, screenWidth * 0.6, 10.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              "assets/h.svg",
              color: Colors.white,
              height: 100.0,
              width: 100.0,
              // allowDrawingOutsideViewBox: true,
            ),
          ),
          SizedBox.fromSize(
            size: Size(1, 20),
          ),
          Text(
            'This app is developed by :',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white, fontSize: 10),
          ),
          SizedBox.fromSize(
            size: Size(1, 20),
          ),
          Text(
            'Hossein Hadi',
            style: Theme.of(context).textTheme.caption.copyWith(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
          SizedBox.fromSize(
            size: Size(1, 80),
          ),
          drawerMenuButton(Icons.home, 'Home', 0),
          Divider(),
          drawerMenuButton(Icons.settings, 'Settings', 1),
          Divider(),
          drawerMenuButton(Icons.person_search, 'About', 0),
          Divider(),
          drawerMenuButton(Icons.help, 'Help', 0),
        ],
      ),
    );

    return Stack(
      children: [
        drawerBackgroundPage,
        backPage,
        GestureDetector(
          onTap: _onPageTapped,
          onHorizontalDragStart: _onPageHorizontalDragStart,
          onHorizontalDragEnd: _onPageHorizontalDragEnd,
          onHorizontalDragUpdate: _onPageHorizontalDragUpdate,
          // onHorizontalDragCancel: ,
          child: AnimatedBuilder(
            animation: _drawerAnimation,
            builder: (context, notChangeChild) {
              return Transform(
                alignment: Alignment.center,
                transform: _drawerShowing
                    ? Matrix4.identity()
                    : Matrix4.identity()
                  ..rotateZ(_interpolate(_drawerAnimation.value, 0, 3.14 / -10))
                  ..scale(
                      _interpolate(_drawerAnimation.value, 1, _drawerScaleDown))
                  ..translate(
                      _interpolate(
                          _drawerAnimation.value, 0.0, _drawerTranslationX),
                      _interpolate(
                          _drawerAnimation.value, 0.0, _drawerTranslationY),
                      _interpolate(
                          _drawerAnimation.value, 0.0, _drawerTranslationZ)),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset.fromDirection(-1, 3),
                          // blurRadius: _interpolate(_drawerAnimationController.value, 0.0, _drawerBlurRadius) ,
                          // spreadRadius:  _interpolate(_drawerAnimationController.value, 0.0, _drawerBlurSpread),
                          blurRadius: 5,
                          spreadRadius: 4,
                          color: Colors.black87)
                    ],
                    borderRadius: BorderRadius.circular(_interpolate(
                        _drawerAnimationController.value,
                        0.0,
                        _drawerBorderRadius)),
                  ),
                  child: notChangeChild,
                ),
              );
            },
            child: frontPageWithTabs,
          ),
        ),
      ],
    );
  }
}
