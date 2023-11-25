import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCard extends StatelessWidget {
  late String label1;
  final String label2;
  late int status1;
  late int status2;
  MyCard(
      {required this.label1,
      required this.label2,
      Key? key,
      required this.status1,
      required this.status2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            RotatedBox(
              quarterTurns: -1,
              child: Text(
                label1,
                style: const TextStyle(
                  color: Color(0x7F2F2E41),
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  height: 0.14,
                ),
              ),
            ),
            status1 == 1
                ? SvgPicture.asset(
                    'assets/images/car_right.svg',
                  )
                : SvgPicture.asset(
                    'assets/images/empty_slot.svg',
                  ),
            const SizedBox(
              width: 10,
            ),
            status2 == 1
                ? SvgPicture.asset(
                    'assets/images/car_left.svg',
                  )
                : SvgPicture.asset(
                    'assets/images/empty_slot.svg',
                  ),
            RotatedBox(
              quarterTurns: 1,
              child: Text(
                label2,
                style: const TextStyle(
                  color: Color(0x7F2F2E41),
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  height: 0.14,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ],
    );
  }
}
