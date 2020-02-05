
class Seat {
  int y;
  String seat;
  int row;
  int column;
  String code;
  int type;
  int status;
  int price;

  Seat(
      {this.y,
      this.seat,
      this.row,
      this.column,
      this.code,
      this.type,
      this.status,
      this.price});

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      y: json['y'] as int,
      seat: json['seat'] as String,
      row: json['rows'] as int,
      column: json['column'] as int,
      code: json['code'] as String,
      type: json['type'] as int,
      status: json['status'] as int,
      price: json['price'] as int,
    );
  }
}

