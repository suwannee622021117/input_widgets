class Drink {
  String? teamname;
  bool? checked;

  Drink(this.teamname, this.checked);

  static getteam() {
    return [
      Drink('ชาเย็น', false),
      Drink('ชานม ', false),
      Drink('ชามะนาว ', false),
      Drink('ชาเขียว ', false),
      Drink('กาแฟ ', false),
      Drink('โกโก้ชาเย็น ', false),
    ];
  }
}