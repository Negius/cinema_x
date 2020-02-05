class User {
  String username;
  String email;
  int id;
  String guid;
  String password;
  int passwordFormatId;
  String passwordSalt;
  bool isStaff;
  bool isActive;
  String fullName;
  String firstName;
  String lastName;
  DateTime birthDay;
  String phoneNumber;
  String idCard;
  bool gender;
  bool isMarried;
  String address;
  String position;
  String favour;
  double pointReward;
  double pointCard;
  String cardCode;
  String cardLevelName;
  int currentCardId;
  bool cardIssued;

  User(
      {this.username,
      this.email,
      this.id,
      this.guid,
      this.password,
      this.passwordFormatId,
      this.passwordSalt,
      this.isStaff,
      this.isActive,
      this.fullName,
      this.firstName,
      this.lastName,
      this.birthDay,
      this.phoneNumber,
      this.idCard,
      this.gender,
      this.isMarried,
      this.address,
      this.position,
      this.favour,
      this.pointReward,
      this.pointCard,
      this.cardCode,
      this.cardLevelName,
      this.currentCardId,
      this.cardIssued});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["Id"] as int,
        guid: json["CustomerGuid"] as String,
        username: json["Username"] as String,
        email: json["Email"] as String,
        password: json["Password"] as String,
        passwordFormatId: json["PasswordFormatId"] as int,
        passwordSalt: json["PasswordSalt"] as String,
        isStaff: json["IsStaff"] as bool,
        isActive: json["Active"] as bool,
        fullName: json["FullName"] as String,
        firstName: json["CustomerFirstName"] as String,
        lastName: json["CustomerLastName"] as String,
        birthDay: DateTime.parse(json["BirthDay"] as String),
        phoneNumber: json["Mobile"] as String,
        idCard: json["IdCard"] as String,
        gender: json["Sex"] as bool,
        isMarried: json["Marriage"] as bool,
        address: json["Address"] as String,
        position: json["Position"] as String,
        favour: json["Favour"] as String,
        pointReward: json["PointReward"] as double,
        pointCard: json["PointCard"] as double,
        cardCode: json["CardCode"] as String,
        cardLevelName: json["CardLevelName"] as String,
        currentCardId: json["CurrentCardId"] as int,
        cardIssued: json["CardIssued"] as bool);
  }
}
