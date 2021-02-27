import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDinnerMeals extends StatefulWidget {
  @override
  _AddDinnerMealsState createState() => _AddDinnerMealsState();
}

class _AddDinnerMealsState extends State<AddDinnerMeals> {
  List<String> nameOfMeals = List<String>();

  bool _validate = false;
  TextEditingController nameController = TextEditingController();

  _saveDinnerList(List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'dinner list';
    final value = list;
    prefs.setStringList(key, value);
  }

  void addItemToList() {
    setState(() {
      nameController.text.isEmpty
          ? _validate = true
          : nameOfMeals.add(nameController.text);
      nameController.clear();
    });
  }

  Future<List<String>> _readDinnerList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'dinner list';
      final value = prefs.getStringList(key) ?? [];
      print('read: $value');
      nameOfMeals = value;
      return value;
    } catch (error, stack) {
      print('Error happened : $stack');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lime,
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text(
            'العشاء',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'اكتب اسم الوجبة هنا',
                ),
              ),
            ),
            RaisedButton(
              color: Colors.pink,
              child: Text(
                'إضافة',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                addItemToList();
                _saveDinnerList(nameOfMeals);
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: _readDinnerList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    nameOfMeals = snapshot.data;
                    return ListView.builder(
                        itemCount: nameOfMeals.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          final name = nameOfMeals[index];
                          return Container(
                            height: 50,
                            color: Colors.pink,
                            margin: EdgeInsets.all(2),
                            child: Center(
                              child: Dismissible(
                                key: Key(name),
                                direction: DismissDirection.startToEnd,
                                child: ListTile(
                                  title: Text(
                                    name,
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        nameOfMeals.removeAt(index);
                                        _saveDinnerList(nameOfMeals);
                                      });
                                    },
                                  ),
                                ),
                                onDismissed: (direction) {
                                  setState(() {
                                    nameOfMeals.removeAt(index);
                                    _saveDinnerList(nameOfMeals);
                                  });
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text("$name تم حذف ")));
                                },
                              ),
                            ),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            (nameOfMeals.isNotEmpty && nameOfMeals != null)
                ? Container(
              child: Text(
                'لحذف أي عنصر يمكنك سحبه إلي سلة المقذوفات',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              padding: const EdgeInsets.all(10),
              height: 50,
              color: Colors.pink,
            )
                : Text('')
          ],
        ),
      ),
    );
  }
}
