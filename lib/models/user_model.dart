
// lib/models/user.dart
class UserModel {
  final String id;
  final String username;
  final String displayName;
  final String fullName;
  final String fidoId;
  final int cardNum;
  final double totalMoney;

  UserModel({
    required this.id,
    required this.username,
    required this.displayName,
    required this.fullName,
    required this.fidoId,
    required this.cardNum,
    required this.totalMoney,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      displayName: json['display_name'] as String,
      fullName: json['full_name'] as String,
      fidoId: json['fido_id'] as String,
      cardNum: json['card_num'] as int,
      totalMoney: (json['totalMoney'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'display_name': displayName,
      'full_name': fullName,
      'fido_id': fidoId,
      'card_num': cardNum,
      'totalMoney': totalMoney,
    };
  }
}