const String firebaseStorageProductImageDir = 'ProductImages';
const String currencySymbol = 'MYR';
const String serverKey = '';
const String collectionAdmin = 'Admins';

abstract class OrderStatus{
  static const String pending = 'Pending';
  static const String processing = 'Processing';
  static const String completed = 'Completed';
  static const String cancelled = 'Cancelled';
  static const String returned = 'Returned';
}

abstract class NotificationType{
  static const String comment = 'New Comment';
  static const String order = 'order';
  static const String user = 'New User';
}

abstract class NotificationTopic{
  static const String order = 'order';
  static const String promo = 'promo';
  static const String user = 'user';
}