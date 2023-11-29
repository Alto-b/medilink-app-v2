// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations



import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/guest/model/usermodel.dart';
import 'package:medilink/guest/pages/login.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

    String userEmail = ''; 
  UserModel? currentUser;
  
   int age=0;

   

   @override
  void initState() {
    super.initState();
    // Call the getUser function when the page is initialized
    getUser();  
    calculateAge();  
  }

  Future<void> getUser() async {
    // Retrieve currentUser email from shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   
   //if(currentUser != null)
    userEmail = prefs.getString('currentUser') ?? '';
    // check the user in Hive using the email
    final userBox = await Hive.openBox<UserModel>('user_db');
    currentUser = userBox.values.firstWhere(
      (user) => user.email == userEmail,
      //orElse: () => null,
    );
    setState(() {
      
    });
    
  }
void calculateAge() {
    if (currentUser != null) {
      String dobString = currentUser!.dob;
      DateTime dob = DateTime.parse(dobString);
      DateTime currentDate = DateTime.now();
      Duration difference = currentDate.difference(dob);
      age = (difference.inDays / 365).floor();
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("PROFILE PAGE",style: appBarTitleStyle(),),
        
      ),

    body: currentUser!=null ?
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          child: Column(
            children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: optionsBoxDecoration(),
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     CircleAvatar(maxRadius: 50),
                      //   ],
                      // ),
                      SizedBox(height: 20,),
                      ListTile(
                        leading: Icon(Icons.person,color: Colors.deepPurple,),
                        title: Text("${currentUser!.fullname}",style: ProfileTextStyle(),),
                      ),
                      ListTile(
                        leading: Icon(Icons.email,color: Colors.red[400],),
                        title: Text("${currentUser!.email}",style: ProfileTextStyle(),),
                      ),
                      ListTile(
                        leading: getGenderIcon(currentUser!.gender),
                        title: Text("${currentUser!.gender}",style: ProfileTextStyle(),),
                      ),
                      ListTile(
                        leading: Icon(Icons.calendar_month,color: Colors.green,),
                        title: Text("${currentUser!.dob}",style: ProfileTextStyle(),),
                      ),
                      ListTile(
                        leading: Icon(Icons.date_range_outlined,color: Colors.amber,),
                        title: Text("$age Years",style: ProfileTextStyle(),),
                      ),
                    ],
                  ),
                ),
              
              ),
            )
             
            
            ],
          ),
        ),
      ),
    )
    :Center(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 200,),
            Text("USER NOT LOGGED IN"),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
            }, child: Text("PROCEED TO LOGIN"))
          ],
        ),
      ),
    )

    );
  }

  



}