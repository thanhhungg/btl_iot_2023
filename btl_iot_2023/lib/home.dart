import 'package:btl_iot_2023/widget/my_car.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PARKING SLOT'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [

              Positioned(
                top: 50,
                left: 200,
                child: Container(
                  height: 240,
                  child: Center(
                    child:  DottedLine(
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
                    label1: 'C01',
                    label2: 'C02',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const DottedLine(),
                  const SizedBox(
                    height: 5,
                  ),
                  MyCard(
                    label1: 'C03',
                    label2: 'C04',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const DottedLine(),
                  const SizedBox(
                    height: 5,
                  ),
                  MyCard(
                    label1: 'C05',
                    label2: 'C06',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const DottedLine(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
