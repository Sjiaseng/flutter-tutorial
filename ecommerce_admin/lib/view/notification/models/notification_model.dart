import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/view/user/models/user_model.dart';

import '../../category/models/comment_model.dart';
import '../../order/models/order_model.dart';

const String collectionNotification = 'Notifications';

const String notificationFieldId = 'notificationId';
const String notificationFieldType = 'type';
const String notificationFieldMessage = 'Message';
const String notificationFieldStatus = 'status';
const String notificationFieldComment = 'comment';
const String notificationFieldUser = 'user';
const String notificationFieldOrder = 'order';
const String notificationFieldTypeData = 'typeData';
const String notificationFieldTitle = 'title';
const String notificationFieldCreatedAt = 'createdAt';

class NotificationModel {
  String? id;
  String? type;
  String? message;
  bool? status;
  CommentModel? commentModel;
  UserModel? userModel;
  OrderModel? orderModel;
  String? typedata;
  String? title;
  String? body;
  DateTime? createdAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.message,
    this.status = false,
    this.commentModel,
    this.userModel,
    this.orderModel,
    this.typedata,
    this.title,
    this.body,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      notificationFieldId: id,
      notificationFieldType: type,
      notificationFieldMessage: message,
      notificationFieldStatus: status,
      notificationFieldComment: commentModel?.toMap(),
      notificationFieldUser: userModel?.toMap(),
      notificationFieldOrder: orderModel?.toMap(),
      notificationFieldTypeData: typedata,
      notificationFieldTitle: title,
      notificationFieldCreatedAt: createdAt,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) => NotificationModel(
    id: map[notificationFieldId],
    type: map[notificationFieldType],
    message: map[notificationFieldMessage],
    status: map[notificationFieldStatus] is bool
        ? map[notificationFieldStatus] as bool
        : map[notificationFieldStatus] == 'true',
    commentModel: map[notificationFieldComment] == null
        ? null
        : CommentModel.fromMap(map[notificationFieldComment]),
    userModel: map[notificationFieldUser] == null
        ? null
        : UserModel.fromFirestore(map[notificationFieldUser]),
    orderModel: map[notificationFieldOrder] == null
        ? null
        : OrderModel.fromFirestore(map[notificationFieldOrder]),
    typedata: map[notificationFieldTypeData],
    title: map[notificationFieldTitle],
    createdAt: map[notificationFieldCreatedAt] == null
        ? null
        : (map[notificationFieldCreatedAt] as Timestamp).toDate(),
  );
}
