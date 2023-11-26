import 'dart:convert';

import 'package:btl_iot_2023/packing/model/data_car_packing.dart';
import 'package:btl_iot_2023/widget/my_car.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PackingSlotPage extends StatefulWidget {
  const PackingSlotPage({Key? key}) : super(key: key);

  @override
  State<PackingSlotPage> createState() => _PackingSlotPageState();
}

class _PackingSlotPageState extends State<PackingSlotPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  Future<void> _configureLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  final channel = WebSocketChannel.connect(
    Uri.parse('wss://appiottest-23a3da89803d.herokuapp.com/ws/sc/parkingLot/'),
  );
  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // Thay thế bằng ID kênh thông báo của bạn
      'your_channel_name', // Thay thế bằng tên kênh thông báo của bạn
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Thông báo',
      'Chỉ còn một chỗ đỗ xe trống!',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  void initState() {
    super.initState();
    _configureLocalNotifications();
    Map<String, dynamic> jsonData = {
      "name": "A10",
      "status": 1
    };
    String jsonString = jsonEncode(jsonData);
    channel.sink.add(jsonString);
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bãi đỗ xe thông minh'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data.toString());
                List<DataCarPacking> listSlotPacking =
                    (jsonDecode(snapshot.data.toString()) as List<dynamic>)
                        .map((e) => DataCarPacking.fromJson(e))
                        .toList();
                int count = listSlotPacking.where((element) => element.status == 1).length;
                if (count == 1) {
                  _showNotification();
                }

                return Stack(
                  children: [
                    Positioned(
                      top: 65,
                      left: 200,
                      child: Container(
                        height: 240,
                        child: Center(
                          child: DottedLine(
                            dashGapLength: 4.0,
                            direction: Axis.vertical,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Số lượng còn trống: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "$count",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Số lượng đã kín chỗ: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${6 - count}",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const DottedLine(),
                        const SizedBox(
                          height: 5,
                        ),
                        MyCard(
                          status1: listSlotPacking[0].status,
                          status2: listSlotPacking[1].status,
                          label1: listSlotPacking[0].name,
                          label2: listSlotPacking[1].name,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const DottedLine(),
                        const SizedBox(
                          height: 5,
                        ),
                        MyCard(
                          status1: listSlotPacking[2].status,
                          status2: listSlotPacking[3].status,
                          label1: listSlotPacking[2].name,
                          label2: listSlotPacking[3].name,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const DottedLine(),
                        const SizedBox(
                          height: 5,
                        ),
                        MyCard(
                          status1: listSlotPacking[4].status,
                          status2: listSlotPacking[5].status,
                          label1: listSlotPacking[4].name,
                          label2: listSlotPacking[5].name,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const DottedLine(),
                      ],
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
