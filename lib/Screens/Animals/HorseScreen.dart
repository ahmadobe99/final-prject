// ignore_for_file: non_constant_identifier_names

import 'package:final_project/CatModels/CatAppBar.dart';
import 'package:final_project/CatModels/CatListView.dart';
import 'package:final_project/Logic/animalapi.dart';
import 'package:final_project/Screens/drawerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HorseScreen extends StatefulWidget {
  const HorseScreen({super.key});

  @override
  State<HorseScreen> createState() => _HorseScreenState();
}

class _HorseScreenState extends State<HorseScreen> with TickerProviderStateMixin {
  var Data ;
  String type = "cat";
  var storage = FlutterSecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    BetFinderApi myobject = BetFinderApi();
    
    myobject.get(type, storage).then((value) {
      setState(() {
        Data = value;
      });
    });
    super.initState();
  }
  void FilterData(params,filter)  {
    setState(() {
      Data = null;
    });
    FilterAnimal object = FilterAnimal();
        object.get(type, storage, filter, params).then((value) {
          setState(() {
           Data = value;
          });
        });
  }

  void PaginationData(page) {
    setState(() {
      Data = null;
    });
    ChangePagination myobject = ChangePagination();
    myobject.get(page, storage, type).then((value) {
      setState(() {
        Data = value;
      });
    });
  }
  


  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 4, vsync: this);
    return Scaffold(
      appBar: const CatAppBar(),
      drawer: DrawerScreen(),
      body: CatListView(
        tabController: _tabController,
        Data: Data,
        type: type,
        FilterData: FilterData,
        PaginationData: PaginationData,
      ),
    );
  }
}
