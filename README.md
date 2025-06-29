# ordertracking

A Flutter-based order tracking app that sends push notifications for order status changes and displays a live tracking progress line. Built following iSUPPLY branding and B2B pharmacy workflow standards.

## 🚀 Features

- 🔔 **Push Notifications** for order status updates:
  - Works in **Foreground**
  - Works in **Background**
  - Works when app is **Terminated**
- 📈 **Live Tracking Progress Line UI**
- 🔄 **Real-time Updates** from Firebase
- ✅ Supports both **Firebase Cloud Messaging (FCM)**, **Local Notifications** and **HSM For Huawei By OneSignal** 

## 🧪 Order Status Flow
Pending → Confirmed → Shipped → Delivered

Each status change triggers:
- A push notification
- UI update of the tracking line

## 📲 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/yousefmohamed35/order_tracking_app.git
cd order_tracking_app
2. flutter pub get
3.⚠️ For security reasons, google-services.json and GoogleService-Info.plist are excluded.
To run the app, add your own Firebase configuration files:

Android: Place google-services.json in android/app/

iOS: Place GoogleService-Info.plist in ios/Runner/

4. flutter run




