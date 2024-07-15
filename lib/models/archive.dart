class ArchiveModel {
  final int invoiceNumber;
  final String customerName;
  final String date;
  final String time;
  final double totalAmount;
  final String items;
  final String username;

  ArchiveModel({
    required this.invoiceNumber,
    required this.customerName,
    required this.date,
    required this.time,
    required this.totalAmount,
    required this.items,
    required this.username,
  });

  factory ArchiveModel.fromMap(Map<String, Object?> map) {
    return ArchiveModel(
      invoiceNumber: map['invoice_number'] as int,
      customerName: map['customer_name'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      totalAmount: map['total_amount'] as double,
      items: map['items'] as String,
      username: map['username'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'invoice_number': invoiceNumber,
      'customer_name': customerName,
      'date': date,
      'time': time,
      'total_amount': totalAmount,
      'items': items,
      'username': username,
    };
  }
}
