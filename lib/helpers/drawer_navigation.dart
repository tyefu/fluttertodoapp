import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/page/dayly/home/home_page.dart';
import 'package:flutter_app_todo_app/page/specify/specifyPage.dart';



import 'package:flutter_app_todo_app/page/weekly/weeklyhome/weekly_home_page.dart';


class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {

  // List<Widget> _categoryList = List<Widget>();
  //
  // CategoryService _categoryService = CategoryService();

  // getAllCategories()async{
  //   List categories =  await _categoryService.readCategories();
  //
  //   categories.forEach((category) {
  //     setState(() {
  //       _categoryList.add(InkWell(
  //         onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
  //           return TodosByCategory(category: category['category'],);
  //         })),
  //         child: ListTile(
  //           title: Text(category['category']),
  //         ),
  //       ));
  //     });
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAllCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://github.com/flutter/plugins/raw/master/packages/video_player/video_player/doc/demo_ipod.gif?raw=true'
                ),
              ),
                accountName: Text('Naoto Baba'), accountEmail: Text("katutyefuu@gmail.com"),
            decoration: BoxDecoration(
              color: Colors.blue,

            ),),
            ListTile(
              leading: Icon(Icons.fact_check_outlined),
              title: Text('毎日やること'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('曜日ごとにやること'),
              onTap: (){

                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeeklyHomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('特定の日にやること'),
              onTap: (){

                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SpecifyPage()));
              },
            ),
            Divider(),
            Column(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
