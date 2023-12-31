// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink/admin/db/dept_functions.dart';
import 'package:medilink/admin/model/deptmodel.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:medilink/user/pages/specialization_search.dart';

class SpecializationPage extends StatefulWidget {
  const SpecializationPage({super.key});

  @override
  State<SpecializationPage> createState() => _SpecializationPageState();
}

class _SpecializationPageState extends State<SpecializationPage> {

final  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    getDepartment();
    
    return Scaffold(

      appBar: AppBar(
        title: Text("OUR SPECIALIZATIONS",style: appBarTitleStyle(),),
         actions: [       
            IconButton(onPressed: (){
              showSearch(
                context: context, 
                delegate: SpecializationSearchDelegate());
            }, icon: Icon(Icons.search))
        ],
      ),


      body:SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                children: [
                  //listing specialization
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
      height: 580,
      child: ValueListenableBuilder(
      valueListenable: deptListNotifier,
      builder: (BuildContext ctx, List<DepartmentModel> departmentList, Widget? child) {
        // Search part
        final filteredDepartments = _searchController.text.isEmpty
            ? departmentList
            : departmentList.where((dept) =>
                dept.dept.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
           
            if (departmentList.isEmpty) {
                    return Center(
                      child: Text("Will be updated soon",
                      style: GoogleFonts.play(
                        fontWeight: FontWeight.w700,
                        fontSize:20,
                        color: Colors.grey),),
                    );
                  }                   
                   
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemBuilder: ((context, index) {
            final data = departmentList[index];
            return Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color:Colors.grey[100],
              child: ListTile(
                horizontalTitleGap: 20,
                contentPadding: EdgeInsets.all(5),
                title: Align(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        backgroundImage: FileImage(
                          File(data.photo),
                        ),
                      ),
                      Text(
                        data.dept,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          itemCount: filteredDepartments.length,
        );
      },
      ),
    ),
    )
         ],
        ),
      ),
     ),
    )
    );
  }
}