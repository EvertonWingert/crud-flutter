class Billet {
  int? id;
  String? name;
  DateTime? dueDate;
  int? price;

  Billet({this.id, this.name, this.dueDate, this.price});

  factory Billet.fromJson(Map<String, dynamic> json) {
    print(json);
    return Billet(
      id: json['id'],
      name: json['name'] as String,
      dueDate: DateTime.parse(json['due_date'] as String),
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'due_date': dueDate?.toIso8601String(),
      'price': price,
    };
  }
}
