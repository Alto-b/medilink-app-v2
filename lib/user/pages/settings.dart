// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:medilink/guest/pages/login.dart';
import 'package:medilink/main.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:medilink/user/pages/help_center.dart';
import 'package:medilink/user/pages/profilepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool isDarkMode=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:Text("SETTINGS",style:appBarTitleStyle(),)
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:  Column(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("PROFILE",style: listtileTitleStyle(), ),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => ProfilePage(),));
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text("PRIVACY POLICY",style: listtileTitleStyle(),),
              onTap: () => _launchPPURL('https://www.freeprivacypolicy.com/live/3138d9d9-db48-4658-8f59-7626c7e75765'),
            ),
            ListTile(
              leading: Icon(Icons.shield),
              title: Text("TERMS AND CONDITIONS",style: listtileTitleStyle(),),
               onTap: () => _launchTCURL('https://www.freeprivacypolicy.com/live/0f39be3a-d8f8-49fc-8679-98a31b67d214'),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("HELP CENTER",style: listtileTitleStyle(),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCenterPage(),));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text("LOGOUT",style: listtileTitleStyle(),),
              onTap: () =>  logOut(context),
            ),

            Spacer(),
              Column(
              children: const [
                Text("v.0.0.4")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [
                Icon(Icons.copyright,color: Colors.grey,),
                Text("Medilink 2023",style: TextStyle(color: Colors.grey),)
              ],
            ),
          
            
          ],
        ),
      ),
    );
  }

//to set dark mode
void darkModeToggle(){
  setState(() {
    if(isDarkMode){
      isDarkMode=false;
    }
    else if(!isDarkMode){
      isDarkMode=true;
    }
  });
}

//to launch url
void _launchPPURL(String url) async{

           Uri url = Uri.parse('https://www.freeprivacypolicy.com/live/3138d9d9-db48-4658-8f59-7626c7e75765');
       if (await launchUrl(url)) {
              //dialer opened
          }else{
          SnackBar(content: Text("couldn't launch the page"));
      }
    } 

void _launchTCURL(String url) async{

           Uri url = Uri.parse('https://www.freeprivacypolicy.com/live/0f39be3a-d8f8-49fc-8679-98a31b67d214');
       if (await launchUrl(url)) {
              //dialer opened
          }else{
          SnackBar(content: Text("couldn't launch the page"));
      }
    } 
//log out
void logOut(BuildContext context){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title:Text("Logout"),
          content: Text("Do you want to leave ?"),
          actions: [
            ElevatedButton(onPressed: (){
              signout(context);
            }, child: Text("Yes")),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("No")),
          ],
        );
      });
    }
//signout
  signout(BuildContext ctx) async{

    final _sharedPrefs= await SharedPreferences.getInstance();
  await _sharedPrefs.clear();

    // ignore: use_build_context_synchronously
    Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>LoginPage()), (route) => false);
    _sharedPrefs.setBool(SAVE_KEY_NAME, false);
  }
}