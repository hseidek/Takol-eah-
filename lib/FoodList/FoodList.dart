import 'dart:math';

import 'package:flutter/material.dart';


class FoodList {

  static List breakfast = [
    'فول',
    'بيض مسلوق وجبنة',
    'بيض أومليت وجبنة',
    'فول وبيض أومليت',
    'تونة',
    'شوفان باللبن والعسل',
    'سندوتشات جبنة بيضا وحلاوة',
    'كوباية لبن وتمر',
  ];

  static List lunch = [
    'صينية بطاطس ورز',
    'شيش طاووق ورز',
    'مكرونة وبانيه',
    'أوردر مندي',
    'أوردر كبسة',
    '   بيتزا',
    'كينج تشيكن',
    'لحمة ستيك ورز',
  ];
  static List dinner = [
    'فول',
    'بيض مسلوق وجبنة',
    'بيض أومليت وجبنة',
    'فول وبيض أومليت',
    'تونة',
    'شوفان باللبن والعسل',
    'سندوتشات جبنة بيضا وحلاوة',
    'كوباية لبن وتمر',
  ];

}


class Data extends ChangeNotifier {

  List _foodData =  [];
  List get fooddata => this._foodData;

  set foodData(List v){
    foodData = v;
    notifyListeners();
  }
}