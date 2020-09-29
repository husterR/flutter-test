import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storage_path/storage_path.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'AddTextPart.dart';


part 'VideoPlayerPart.dart';

part 'WebViewPart.dart';

void main() => runApp(MaterialApp(
    key: Key("App"),
    home: MyApp(items: List<String>.generate(1000, (i) => "Item $i"))));

class MyApp extends StatefulWidget {
  final List<String> items;

  MyApp({Key key, @required this.items}) : super(key: key);

  @override
  MyAppState createState() => MyAppState(items);
}

class MyAppState extends State<MyApp> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> items;

  MyAppState(this.items) : super();

  String getHeaderOfDrawer() {
    return 'Navigationsmenü';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('List-Test'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        key: Key("Drawer"),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              key: Key("DrawerHeader"),
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: CachedNetworkImageProvider(
                      'https://cdn.fluidmobile.de/wp-content/uploads/2019/09/roman_header-1.jpg.webp'),
                ),
              ),
              child: Text(
                getHeaderOfDrawer(),
                key: Key("DrawerHeaderText"),
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              key: Key("WebsiteOpenTile"),
              leading: Icon(Icons.web),
              title: Text('WebView-Test'),
              hoverColor: Colors.blue,
              onTap: () {
                _scaffoldKey.currentState.openEndDrawer();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return WebViewPage();
                  },
                ));
              },
            ),
            ListTile(
              key: Key("VideoOpenTile"),
              leading: Icon(Icons.ondemand_video),
              title: Text('Video-Test'),
              hoverColor: Colors.blue,
              onTap: () {
                _scaffoldKey.currentState.openEndDrawer();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return VideoPlayerScreen();
                  },
                ));
              },
            ),
            ListTile(
              key: Key("TextOpenTile"),
              leading: Icon(Icons.text_fields),
              title: Text('Text-Test'),
              hoverColor: Colors.blue,
              onTap: () {
                _scaffoldKey.currentState.openEndDrawer();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AddTextPage();
                  },
                ));
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        // Add a key to the ListView. This makes it possible to
        // find the list and scroll through it in the tests.
        key: Key('long_list'),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              "assets/icons/flutter.png",
              color: Colors.blue,
              key: Key("item_${index}_icon"),
            ),
            title: Text(
              '${items[index]}',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400),
              // Add a key to the Text widget for each item. This makes
              // it possible to look for a particular item in the list
              // and verify that the text is correct
              key: Key('item_${index}_text'),
            ),
            subtitle: Text(
              "Subtitle to Item #$index \nand its description",
              key: Key('item_${index}_description'),
              style: TextStyle(color: Colors.black),
            ),
            isThreeLine: true,
            trailing: Image.asset("assets/icons/android.png"),
          );
        },
      ),
    );
  }
}
