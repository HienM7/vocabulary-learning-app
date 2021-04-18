import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:vocabulary_learning_app/Screens/Shared/footer.dart';
import 'package:vocabulary_learning_app/Home/widgets/explore_drawer.dart';
import 'package:flutter/rendering.dart';
import 'package:vocabulary_learning_app/constants/router_constants.dart';
import 'package:vocabulary_learning_app/models/app_router.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _isHovering = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: screenSize.width > 800 ?
      PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.blueGrey[700].withOpacity(0.6),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width*0.028, vertical: 20),
            child: Row(
              children: [
                Text(' VOCABLEARN',
                  style: TextStyle(
                    color: Colors.white.withOpacity(1),
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        onHover: (value) {
                          setState(() {
                            _isHovering[0] = value;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => AppRouter.router.navigateTo(
                                context, AppRoutes.homePage.route,
                                transition: TransitionType.none),
                                // ignore: todo
                                // TODO: Auth required here
                                // $.homePage$ if logged in else $.login$
                              child: Text(
                                'Course',
                                style: TextStyle(
                                  color: _isHovering[0]
                                      ? Colors.yellow.withOpacity(1)
                                      : Colors.white.withOpacity(1),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(height: 3),
                            // For showing an underline on hover
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[0],
                              child: Container(
                                height: 3,
                                width: 60,
                                color: Colors.white.withOpacity(1),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: screenSize.width / 20),
                      InkWell(
                        onTap: () {},
                        onHover: (value) {
                          setState(() {
                            _isHovering[1] = value;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Contact Us',
                              style: TextStyle(
                                color: _isHovering[1]
                                    ? Colors.yellow.withOpacity(1)
                                    : Colors.white.withOpacity(1),
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 3),
                            // For showing an underline on hover
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[1],
                              child: Container(
                                height: 3,
                                width: 90,
                                color: Colors.white.withOpacity(1),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  onHover: (value) {
                    setState(() {
                      _isHovering[2] = value;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => AppRouter.router.navigateTo(
                          context, AppRoutes.signup.route,
                          transition: TransitionType.none),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: _isHovering[2]
                                  ? Colors.yellow.withOpacity(1)
                                  : Colors.white.withOpacity(1),
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ),
                      SizedBox(height: 3),
                      // For showing an underline on hover
                      Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        maintainSize: true,
                        visible: _isHovering[2],
                        child: Container(
                          height: 3,
                          width: 66,
                          color: Colors.white.withOpacity(1),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: screenSize.width / 30,
                ),
                InkWell(
                  onTap: () {},
                  onHover: (value) {
                    setState(() {
                      _isHovering[3] = value;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => AppRouter.router.navigateTo(
                          context, AppRoutes.login.route,
                          transition: TransitionType.none),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              color: _isHovering[3]
                                  ? Colors.yellow.withOpacity(1)
                                  : Colors.white.withOpacity(1),
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ),
                      SizedBox(height: 3),
                      // For showing an underline on hover
                      Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        maintainSize: true,
                        visible: _isHovering[3],
                        child: Container(
                          height: 3,
                          width: 50,
                          color: Colors.white.withOpacity(1),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
      : AppBar(
        backgroundColor: Colors.blueGrey[700].withOpacity(0.6),
        elevation: 0,
        centerTitle: true,
        title: Text(' VOCABLEARN',
          style: TextStyle(
            color: Colors.white.withOpacity(1),
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: ExploreDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //screensize larger
            screenSize.width > 800 ?
            Stack(
              children: [
                Container( // image below the top bar
                  child: SizedBox(
                    height: screenSize.height,
                    width: screenSize.width,
                    child: Image.asset( 
                      'assets/images/home_background.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Center(
                  heightFactor: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height * 0.78,
                      left: screenSize.width / 5,
                      right: screenSize.width / 5,
                    ),
                    child: TextButton(
                      onPressed: () => AppRouter.router.navigateTo(
                        context, AppRoutes.homePage.route,
                        transition: TransitionType.none),
                      child: Text(
                        'Get started',
                        style: TextStyle(color: Colors.white, fontSize: 32)),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.amber)
                          )
                        )
                      ),
                    )
                  ),
                )
              ],
            )
            //screensize small
            : Stack(
              children: [
                Container( // image below the top bar
                  child: SizedBox(
                    width: screenSize.width,
                    child: Image.asset( 
                      'assets/images/home_background.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Center(
                  heightFactor: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height * 0.31,
                      left: screenSize.width / 5,
                      right: screenSize.width / 5,
                    ),
                    child: TextButton(
                      onPressed: () => AppRouter.router.navigateTo(
                        context, AppRoutes.homePage.route,
                        transition: TransitionType.none),
                      child: Text(
                        'Get started',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.amber)
                          )
                        )
                      ),
                    )
                  ),
                )
              ],
            ),
            Container(
              width: screenSize.width*0.85,
              child: screenSize.width > 800 ?
              //screensize larger
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( // image below the top bar
                    child: SizedBox(
                      width: screenSize.width*0.17,
                      child: Image.asset( 
                      'assets/images/home_background_piece.png',
                      fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(screenSize.width*0.075, screenSize.width*0.0268, 0, screenSize.width*0.0268),
                        child: SizedBox(
                          width: screenSize.width*0.605,
                          child: AutoSizeText(
                            'Why learn English with VocabLearn',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width*0.68,
                        child: AutoSizeText(
                          'VocabLearn is a English learning website with simple and friendly UI, which provides you with necessary features to start building your vocabulary with ease and fun. Check out some basic features you can try to improve your vocabulary below',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 4,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, screenSize.width*0.0134, 0, 0),
                        child: screenSize.width > 800 ?
                        Row(
                          children: [
                            Icon(
                              Icons.create_new_folder,
                              color: Colors.orange[600],
                              size: 35,
                            ),
                            SizedBox(width: 20),
                            Text('Create a list of new words',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        )
                        : Row(
                          children: [
                            Icon(
                              Icons.create_new_folder,
                              color: Colors.orange[600],
                              size: 26,
                            ),
                            SizedBox(width: 20),
                            Text('Create a list of new words',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, screenSize.width*0.0134, 0, 0),
                        child: screenSize.width > 800 ?
                        Row(
                          children: [
                            Icon(
                              Icons.share_outlined,
                              color: Colors.orange[600],
                              size: 35,
                            ),
                            SizedBox(width: 20),
                            Text('Share your lists with other users',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        )
                        : Row(
                          children: [
                            Icon(
                              Icons.share_outlined,
                              color: Colors.orange[600],
                              size: 26,
                            ),
                            SizedBox(width: 20),
                            Text('Share your lists with other users',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, screenSize.width*0.0134, 0, 0),
                        child: screenSize.width > 800 ?
                        Row(
                          children: [
                            Icon(
                              Icons.public,
                              color: Colors.orange[600],
                              size: 35,
                            ),
                            SizedBox(width: 20),
                            Text('Browse public word lists',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        )
                        : Row(
                          children: [
                            Icon(
                              Icons.public,
                              color: Colors.orange[600],
                              size: 26,
                            ),
                            SizedBox(width: 20),
                            Text('Browse public word lists',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, screenSize.width*0.0134, 0, 0),
                        child: screenSize.width > 800 ?
                        Row(
                        children: [
                          Icon(
                            Icons.games_outlined,
                            color: Colors.orange[600],
                            size: 35,
                          ),
                          SizedBox(width: 20),
                          Text('Play game to remember new words',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      )
                      : Row(
                        children: [
                          Icon(
                            Icons.games_outlined,
                            color: Colors.orange[600],
                            size: 26,
                          ),
                          SizedBox(width: 20),
                          Text('Play game to remember new words',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      )
                    ],
                  ),
                ],
              )
              // screensize small
              : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, screenSize.width*0.0268, 0, 0),
                    child: SizedBox(
                      width: screenSize.width*0.85,
                      child: AutoSizeText(
                        'Why learn English with VocabLearn',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  Container( // image below the top bar
                    child: SizedBox(
                      width: screenSize.width*0.35,
                      child: Image.asset( 
                      'assets/images/home_background_piece.png',
                      fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width*0.85,
                    child: AutoSizeText(
                      'VocabLearn is a English learning website with simple and friendly UI, which provides you with necessary features to start building your vocabulary with ease and fun. Check out some basic features you can try to improve your vocabulary below',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, screenSize.width*0.0134, 0, 0),
                    child: Row(
                    children: [
                      Icon(
                        Icons.create_new_folder,
                        color: Colors.orange[600],
                        size: 35,
                      ),
                      SizedBox(width: 20),
                      Text('Create a list of new words',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, screenSize.width*0.0134, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.share_outlined,
                          color: Colors.orange[600],
                          size: 35,
                        ),
                        SizedBox(width: 20),
                        Text('Share your lists with other users',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, screenSize.width*0.0134, 0, 0),
                    child: Row(
                    children: [
                      Icon(
                        Icons.public,
                        color: Colors.orange[600],
                        size: 35,
                      ),
                      SizedBox(width: 20),
                      Text('Browse public word lists',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, screenSize.width*0.0134, 0, 0),
                    child: Row(
                    children: [
                      Icon(
                        Icons.games_outlined,
                        color: Colors.orange[600],
                        size: 35,
                      ),
                      SizedBox(width: 20),
                      Text('Play game to remember new words',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  )
                  )
                ],
              ),
            ),
            // Home footer
            Footer(),
          ],
        )
      ),
    );
  }
}
