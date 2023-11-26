class HistoryInOut {
  String? name;
  String? lcNumber;
  String? timeIn;
  String? timeOut;
  int? numIn;
  int? countTime;
  int? cash;

  HistoryInOut(
      {this.name,
        this.lcNumber,
        this.timeIn,
        this.timeOut,
        this.numIn,
        this.countTime,
        this.cash});

  HistoryInOut.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lcNumber = json['lc_number'];
    timeIn = json['timeIn'];
    timeOut = json['timeOut'];
    numIn = json['numIn'];
    countTime = json['countTime'];
    cash = json['cash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lc_number'] = this.lcNumber;
    data['timeIn'] = this.timeIn;
    data['timeOut'] = this.timeOut;
    data['numIn'] = this.numIn;
    data['countTime'] = this.countTime;
    data['cash'] = this.cash;
    return data;
  }
}
