class RentalModel {
  final int? id;
  final int userId;
  final int carId;
  final String carName;
  final String carBrand;
  final String carType;
  final String carImageUrl;
  final double carPricePerDay;
  final String renterName;
  final int rentalDays;
  final String startDate;
  final double totalCost;
  final String status;

  RentalModel({
    this.id,
    required this.userId,
    required this.carId,
    required this.carName,
    required this.carBrand,
    required this.carType,
    required this.carImageUrl,
    required this.carPricePerDay,
    required this.renterName,
    required this.rentalDays,
    required this.startDate,
    required this.totalCost,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'carId': carId,
      'carName': carName,
      'carBrand': carBrand,
      'carType': carType,
      'carImageUrl': carImageUrl,
      'carPricePerDay': carPricePerDay,
      'renterName': renterName,
      'rentalDays': rentalDays,
      'startDate': startDate,
      'totalCost': totalCost,
      'status': status,
    };
  }

  factory RentalModel.fromMap(Map<String, dynamic> map) {
    return RentalModel(
      id: map['id'],
      userId: map['userId'],
      carId: map['carId'],
      carName: map['carName'],
      carBrand: map['carBrand'],
      carType: map['carType'],
      carImageUrl: map['carImageUrl'],
      carPricePerDay: map['carPricePerDay'],
      renterName: map['renterName'],
      rentalDays: map['rentalDays'],
      startDate: map['startDate'],
      totalCost: map['totalCost'],
      status: map['status'],
    );
  }

  RentalModel copyWith({
    int? id,
    int? userId,
    int? carId,
    String? carName,
    String? carBrand,
    String? carType,
    String? carImageUrl,
    double? carPricePerDay,
    String? renterName,
    int? rentalDays,
    String? startDate,
    double? totalCost,
    String? status,
  }) {
    return RentalModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      carId: carId ?? this.carId,
      carName: carName ?? this.carName,
      carBrand: carBrand ?? this.carBrand,
      carType: carType ?? this.carType,
      carImageUrl: carImageUrl ?? this.carImageUrl,
      carPricePerDay: carPricePerDay ?? this.carPricePerDay,
      renterName: renterName ?? this.renterName,
      rentalDays: rentalDays ?? this.rentalDays,
      startDate: startDate ?? this.startDate,
      totalCost: totalCost ?? this.totalCost,
      status: status ?? this.status,
    );
  }
}
