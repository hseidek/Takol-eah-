import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takol_eah_app/FoodList/FoodList.dart';
import 'package:takol_eah_app/UI/AddLunchMeals.dart';

import 'AddDinnerMeals.dart';
import 'AddMeals.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int randomIndexBreakfast;
  int randomIndexLunch;
  int randomIndexDinner;

  @override
  Widget build(BuildContext context) {
    _readFetarList() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final key = 'fetar list';
        final value = prefs.getStringList(key) ?? [];
        print('read: $value');
        return value;
      } catch (error, stack) {
        print('Error happened : $stack');
      }
    }

    _readLunchList() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final key = 'lunch list';
        final value = prefs.getStringList(key) ?? [];
        print('read: $value');
        return value;
      } catch (error, stack) {
        print('Error happened : $stack');
      }
    }

    _readDinnerList() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final key = 'dinner list';
        final value = prefs.getStringList(key) ?? [];
        print('read: $value');
        return value;
      } catch (error, stack) {
        print('Error happened : $stack');
      }
    }
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'متهوش مني واسأل الجني',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.pinkAccent,
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.add),
              onCanceled: () {},
              color: Colors.lime,
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () async {
                          await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddMeals()));

//                       /* isBack= */ await Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => AddMeals()));
                        },
                        child: Text(
                          'اكتب فطارك هنا',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                        child: InkWell(
                      onTap: () async {
                        await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddLunchMeals()));
                      },
                      child: Text(
                        'اكتب غداك هنا',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )),
                    PopupMenuItem(
                        child: InkWell(
                          onTap: () async {
                            await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddDinnerMeals()));
                          },
                          child: Text(
                      'اكتب عشاك هنا',
                      style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                    ),
                        ))
                  ])
        ],
      ),
      backgroundColor: Colors.pink,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'تاكل ايه النهاردة !؟',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 75,
              width: 200,
              child: RaisedButton(
                color: Colors.green,
                onPressed: () async {
                  List<String> list = await _readFetarList();

                  if (list.isNotEmpty) {
                    randomIndexBreakfast = Random().nextInt(
                      list.length,
                    );
                  }

                  print(randomIndexBreakfast);
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.limeAccent,
                            title: Text(
                              'هتفطر يا سيدي',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            content: Text(
                              list.isNotEmpty
                                  ? list[randomIndexBreakfast]
                                  : "(+)أضف الوجبات من علامة",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        });
                  });
                },
                child: Text(
                  'الفطار',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 40),
                ),
              ),
            ),
            SizedBox(
              height: 75,
              width: 200,
              child: RaisedButton(
                color: Colors.green,
                onPressed: () async {
                  List<String> list = await _readLunchList();

                  if (list.isNotEmpty) {
                    randomIndexLunch = Random().nextInt(
                      list.length,
                    );
                  }
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.limeAccent,
                            title: Text(
                              'هتتغدي يا سيدي',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            content: Text(
                              list.isNotEmpty
                                  ? list[randomIndexLunch]
                                  : "(+)أضف الوجبات من علامة",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        });
                  });
                },
                child: Text(
                  'الغداء',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 40),
                ),
              ),
            ),
            SizedBox(
              height: 75,
              width: 200,
              child: RaisedButton(
                color: Colors.green,
                onPressed: () async {
                  List<String> list = await _readDinnerList();

                  if (list.isNotEmpty) {
                    randomIndexDinner = Random().nextInt(
                      list.length,
                    );
                  }
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.limeAccent,
                            title: Text(
                              'هتتعشي يا سيدي',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            content: Text(
                              list.isNotEmpty
                                  ? list[randomIndexDinner]
                                  : "(+)أضف الوجبات من علامة",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        });
                  });
                },
                child: Text(
                  'العشاء',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
