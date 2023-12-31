// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink/admin/db/hosp_functions.dart';
import 'package:medilink/admin/model/hospmodel.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:medilink/user/pages/hospitals_search.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {

final  TextEditingController _searchController = TextEditingController();

@override
void initState(){
  super.initState();
  getHosp();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //appbar
      appBar: AppBar(
        title: Text("OUR HOSPITALS",style: appBarTitleStyle()),
        actions: [
          
            IconButton(onPressed: (){
              showSearch(
                context: context, 
                delegate: HospSearchDelegate());
            }, icon: Icon(Icons.search))
        ],
      ) ,

      body:SingleChildScrollView(
        child: Center(
          child: Column(
              children: [
                //listing specialization
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                  height: 800,
                  child: ValueListenableBuilder(
                    valueListenable: hospListNotifier,
                    builder: (BuildContext ctx, List<HospModel> hospitalList,Widget? child) {
                   
                   //search part
                   final filteredHospitals=_searchController.text.isEmpty
                   ?hospitalList
                   :hospitalList.where((hosp) => 
                   hosp.hosp.toLowerCase().contains(_searchController.text.toLowerCase())).toList();

                    if (hospitalList.isEmpty) {
                    return Center(
                      child: Text("Will be updated soon",
                      style: GoogleFonts.play(
                        fontWeight: FontWeight.w700,
                        fontSize:20,
                        color: Colors.grey),),
                    );
                  }                   
                   
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                      itemBuilder:((context, index) {
                        final data=hospitalList[index]; 
                          return SizedBox(
                            height: 60,
                            child: Container(
                             decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.deepPurple.withOpacity(0.7),
                                  ),
                                   borderRadius: BorderRadius.circular(30),
                                   color: Colors.white,
                    
                                ),
                              child: ListTile(
                                //tileColor: Colors.blue,
                                horizontalTitleGap:20,
                                contentPadding: EdgeInsets.all(5),
                                //leading: Text("${index+1}"),
                                // title: Align(child: Text(data.dept)),     
                                title: Align(alignment: Alignment.topCenter,
                                  child: Text(data.hosp,style: 
                                      TextStyle(
                                          fontSize: 20,
                                          fontWeight:FontWeight.w600,
                                          color: Colors.black87,
                                           ),)),                          
                              ),
                            ),
                          );
                      }) , 
                                       separatorBuilder: ((context, index) {
                      return const Divider(color: Colors.white,);
                      }), 
                                      itemCount:filteredHospitals.length),
                    );
                               }, ),
                              ),
                ),
              ],
          ),
        ),
      )
    );
  }


}