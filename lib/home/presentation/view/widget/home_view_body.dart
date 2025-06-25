import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:ordertracking/core/helper/firebase_message_helper.dart';
import 'package:ordertracking/core/helper/service_locator.dart';

import 'custom_button.dart';
import 'custom_time_line_tile.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    loadStatus();
  }

  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<void> saveStatus(String status) async {
    try {
      await secureStorage.write(key: 'last', value: status);
      log("✅ Saved status securely: $status");
    } catch (e) {
      log("❌ SecureStorage error: $e");
    }
  }

  final List<String> titles = ['Pending', 'Confirmed', 'Shipped', 'Delivered'];
  int currentIndex = 0;
  Future<void> loadStatus() async {
    String? state = await secureStorage.read(key: 'last');
    log(state??"not");
    if (state != null) {
      int index = titles.indexOf(state);
      if (index != -1) {
        currentIndex = index;
        setState(() {
          
        });
      }
    }
  }

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
                onPressed: () async {
                  currentIndex = 1;
                  log(titles[currentIndex]);
                  await saveStatus(titles[currentIndex]);
                  getIt.get<FirebaseMessageHelper>().sendNotification(
                    title: 'Order Status Update with Ali',
                    body: 'Your order status changed from pending to confirm',
                  );
                  setState(() {});
                },
              ),
              CustomButton(
                title: 'ship',
                onPressed: () async {
                  currentIndex = 2;
                  await saveStatus(titles[currentIndex]);
                  getIt.get<FirebaseMessageHelper>().sendNotification(
                    title: 'Order Status Update with Ali',
                    body: 'Your order status changed from confirmed to shipped',
                  );
                  setState(() {});
                },
              ),
              CustomButton(
                title: 'delivre',
                onPressed: () async {
                  currentIndex = 3;
                  await saveStatus(titles[currentIndex]);
                  getIt.get<FirebaseMessageHelper>().sendNotification(
                    title: 'Order Status Update with Ali',
                    body: 'Your order status changed from shipped to delivered',
                  );
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
