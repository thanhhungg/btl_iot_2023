class DataCarPacking {
  String name;
  int status;

  DataCarPacking({required this.name, required this.status});

  factory DataCarPacking.fromJson(Map<String, dynamic> json) {
    return DataCarPacking(
      name: json['name'] as String,
      status: json['status'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
    };
  }
}
