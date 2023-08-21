class Order {
  final String carModel;
  final String carNumber;
  final String userName;
  final DateTime orderDate;
  final String packageName;
  final DateTime serviceDateTime;

  Order({
    required this.carModel,
    required this.carNumber,
    required this.userName,
    required this.orderDate,
    required this.packageName,
    required this.serviceDateTime,
  });
}
