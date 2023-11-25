import 'dart:convert';

import 'package:btl_iot_2023/packing/model/data_car_packing.dart';
import 'package:btl_iot_2023/widget/my_car.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PackingSlotPage extends StatefulWidget {
  const PackingSlotPage({Key? key}) : super(key: key);

  @override
  State<PackingSlotPage> createState() => _PackingSlotPageState();
}

class _PackingSlotPageState extends State<PackingSlotPage> {
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://appiottest-23a3da89803d.herokuapp.com/ws/sc/parkingLot/'),
  );
  @override
  void initState() {
    super.initState();
    channel.sink.add('Hello!');
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
          ),],
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

                return Stack(
                  children: [
                    Positioned(
                      top: 50,
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
                          height: 50,
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
