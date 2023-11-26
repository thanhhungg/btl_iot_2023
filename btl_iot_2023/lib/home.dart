import 'package:btl_iot_2023/login/model/data_user.dart';
import 'package:btl_iot_2023/map/map_page.dart';
import 'package:btl_iot_2023/packing/screen/packing_slot.dart';
import 'package:btl_iot_2023/user_setting/user_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login/cubit/login_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          LocationPermission permission;
          permission = await Geolocator.requestPermission();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapSample()),
          );
        },
        child: const Icon(Icons.map),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: StylishBottomBar(

        hasNotch: true,
        currentIndex: _currentIndex,
        onTap: (index) async {
          setState(() {
            _currentIndex = index;
          });

          // Handle button tap
          if (index == 2) {
            LocationPermission permission;
            permission = await Geolocator.requestPermission();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapSample()),
            );
          }
          if (index == 3) {
            final phoneNumber = 'tel:+84357102';
            if (await canLaunch(phoneNumber)) {
              await launch(phoneNumber);
            } else {
              throw 'Could not launch $phoneNumber';
            }
          }
        },
        items: [
          BottomBarItem(
            selectedColor: Colors.blue,
              icon: Icon(Icons.home,size: 20,),
              title: Text(
                'Trang chủ',
                style: TextStyle(fontSize: 12),
              )),
          BottomBarItem(
              selectedColor: Colors.blue,
              icon: Icon(Icons.monetization_on_outlined,size: 20,),
              title: Text(
                'Thanh toán',
                style: TextStyle(fontSize: 12),
              )),
          BottomBarItem(
              selectedColor: Colors.blue,
              icon: Icon(Icons.home ,size: 20,),
              title: Text(
                'Map',
                style: TextStyle(fontSize: 12),
              )),
          BottomBarItem(
              selectedColor: Colors.blue,
              icon: Icon(Icons.phone  ,size: 20,),
              title: Text(
                'Phản hồi',
                style: TextStyle(fontSize: 12),
              )),
          BottomBarItem(
              selectedColor: Colors.blue,
              icon: Icon(Icons.account_circle ,size: 20,),
              title: Text(
                'Cá nhân',
                style: TextStyle(fontSize: 12),
              )),
        ],
        option: AnimatedBarOptions(
          iconSize: 30,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.Default,
          opacity: 0.3,
        ),
      ),
      body: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ], child: _buildPage()),
    );
  }

  Widget _buildPage() {

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _getPage(),
    );
  }

  Widget _getPage() {
    switch (_currentIndex) {
      case 0:
        return const PackingSlotPage();
      case 4:
        return const SettingsScreen();
      default:
        return Container(); // Fallback to an empty widget
    }
  }
}