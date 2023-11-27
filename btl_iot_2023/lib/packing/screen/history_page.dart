import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../cubit/history_in_out_cubit.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryInOutCubit _historyInOutCubit = HistoryInOutCubit();
  @override
  void initState() {
    super.initState();
    _historyInOutCubit.getHistoryInOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Lịch sử'),
      ),
      body: BlocListener<HistoryInOutCubit, HistoryInOutState>(
        listener: (context, state) {
          if (state is HistoryInOutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<HistoryInOutCubit, HistoryInOutState>(
            bloc: _historyInOutCubit,
            builder: (context, state) {
              if (state is HistoryInOutSuccess) {
                return ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      utf8.decode(
                                          latin1.encode(state.data[index].name)),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blueAccent),
                                    ),
                                    Text(
                                      ' đã gửi xe vào lúc',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      size: 18,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Ngày vào: ${state.data[index].timeIn.split(' ')[0]}"),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_circle_right_outlined,
                                      size: 18,
                                      color: Colors.orange,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Thời gian vào: ${state.data[index].timeIn.split(' ')[1]}"),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_circle_left_outlined,
                                      size: 18,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Thời gian ra: ${state.data[index].timeOut!=""?state.data[index].timeOut.split(' ')[1]:'Chưa ra'}"),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.money,
                                      size: 18,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Tiền phải trả: ${state.data[index].cash}"),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.car_repair,
                                      size: 18,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Biển số xe: ${state.data[index].lcNumber}"),
                                  ],
                                ),

                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 18,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Thời gian gửi: ${formatDuration(state.data[index].countTime)}"),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    );
                  },
                );
              } else if(state is HistoryInOutFailure) {
              return Container(
                child: Center(
                  child: Text("Chưa có thông tin lịch sủ"),
                ),
              );
              }
              else{
                return _buildSkeletonItem();
              }
            }),
      ),
    );
  }
}
Widget _buildSkeletonItem() {
  return Skeletonizer(
    child: ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'name',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueAccent),
                        ),
                        Text(
                          ' đã gửi xe vào lúc',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Ngày vào:"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 18,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Thời gian vào: "),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_left_outlined,
                          size: 18,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Thời gian ra:'Chưa ra'}"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.money,
                          size: 18,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Tiền phải trả: "),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.car_repair,
                          size: 18,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Biển số xe:"),
                      ],
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 18,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Thời gian gửi:"),
                      ],
                    ),
                  ]),
            ),
          ),
        );
      }
    ),
  );
}
String formatDuration(int totalMinutes) {
  int hours = totalMinutes ~/ 60;
  int remainingMinutes = totalMinutes % 60;
  int seconds = remainingMinutes * 60;

  String hoursStr = hours.toString().padLeft(2, '0');
  String minutesStr = remainingMinutes.toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  return '$hoursStr:$minutesStr:$secondsStr';
}
