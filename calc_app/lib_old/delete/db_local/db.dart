// import 'dart:developer';

// import 'package:calc_app/domain/entities/order.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../main.dart';

// class Db {
//   static late SharedPreferences localPref;
//   Future<List<OrderEntity>> delivers = _loadListDeliver();

//   Db._privateConstructor();
//   static final Db _instance = Db._privateConstructor();
//   factory Db() {
//     return _instance;
//   }

//   static Future<List<OrderEntity>> _loadListDeliver() async {
//     log('------This is how much times function call loadListDeliver');
//     await App.init();
//     final List<OrderEntity> newDelivers = [];
//     final listDeliversInJson = Db.localPref.getStringList('delivers');
//     if (listDeliversInJson == null) {
//       return newDelivers;
//     }
//     for (var e in listDeliversInJson) {
//       final deliver = OrderEntity.fromJson(e);
//       newDelivers.add(deliver);
//     }
//     return newDelivers;
//   }

//   void pushAllDeliversInDb(List<OrderEntity> delivers) async {
//     List<String> newList = [];
//     for (var e in delivers) {
//       final oldDeliver = OrderEntity(
//           id: e.id, component: e.component /*, editTime: e.editTime*/);
//       newList.add(oldDeliver.toJson());
//     }

//     localPref.setStringList('delivers', newList);
//   }
// }
