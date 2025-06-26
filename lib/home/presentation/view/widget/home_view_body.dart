import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ordertracking/core/helper/firebase_message_helper.dart';
import 'package:ordertracking/core/helper/service_locator.dart';
import 'package:ordertracking/core/helper/secure_storage_helper.dart';
import '../../../data/extensions/order_status_extension.dart';
import 'custom_button.dart';
import 'custom_time_line_tile.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final secureStorage = getIt<SecureStorageHelper>();
  OrderStatus currentStatus = OrderStatus.pending;

  @override
  void initState() {
    super.initState();
    loadLastStatus();
  }

  Future<void> loadLastStatus() async {
    final saved = await secureStorage.read('last');
    log('📦 Loaded Status: ${saved ?? "None"}');
    if (saved != null) {
      setState(() {
        currentStatus = OrderStatusExtension.fromLabel(saved)!;
      });
    }
  }

  Future<void> updateStatus(OrderStatus newStatus) async {
    final from = currentStatus.label;
    final to = newStatus.label;

    setState(() {
      currentStatus = newStatus;
    });

    await secureStorage.save('last', to);
    await getIt<FirebaseMessageHelper>().sendNotification(
      title: 'Order Status Update with Ali',
      body: 'Your order status changed from $from to $to',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const SizedBox(height: 50),
          Center(
            child: Text(
              'Current Status: ${currentStatus.label}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          for (var status in OrderStatus.values)
            CustomTimeLineTile(
              title: status.label,
              isDone: currentStatus.index >= status.index,
              isFirst: status == OrderStatus.values.first,
              isLast: status == OrderStatus.values.last,
              isLeft: status.index.isOdd,
            ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                title: 'Confirm',
                onPressed: () => updateStatus(OrderStatus.confirmed),
              ),
              CustomButton(
                title: 'Ship',
                onPressed: () => updateStatus(OrderStatus.shipped),
              ),
              CustomButton(
                title: 'Deliver',
                onPressed: () => updateStatus(OrderStatus.delivered),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
