import 'package:flutter/material.dart';
import 'custom_button.dart';
import 'custom_time_line_tile.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final List<String> titles = ['Pending', 'Confirmed', 'Shipped', 'Delivered'];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          SizedBox(height: 50),
          Center(
            child: Text(
              'Current Status : ${titles[currentIndex]}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          CustomTimeLineTile(
            isFirst: true,
            isDone: true,
            title: titles[0],
            isLeft: false,
          ),
          CustomTimeLineTile(
            isDone: currentIndex > 0,
            title: titles[1],
            isLeft: true,
          ),
          CustomTimeLineTile(
            isDone: currentIndex > 1,
            title: titles[2],
            isLeft: false,
          ),
          CustomTimeLineTile(
            isLast: true,
            isDone: currentIndex > 2,
            title: titles[3],
            isLeft: true,
          ),
          SizedBox(height: 16),
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                title: 'confirme',
                onPressed: () {
                  currentIndex = 1;
                  setState(() {});
                },
              ),
              CustomButton(
                title: 'ship',
                onPressed: () {
                  currentIndex = 2;
                  setState(() {});
                },
              ),
              CustomButton(
                title: 'delivre',
                onPressed: () {
                  currentIndex = 3;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
