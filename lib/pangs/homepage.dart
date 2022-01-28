import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:input_widgets/pangs/drinks.dart';
import 'package:input_widgets/pangs/model.dart';
import 'package:input_widgets/pangs/year_std.dart';

import 'model.dart';

class Inputwidgets extends StatefulWidget {
  const Inputwidgets({Key? key}) : super(key: key);

  @override
  _InputwidgetsState createState() => _InputwidgetsState();
}

class _InputwidgetsState extends State<Inputwidgets> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _pasword = TextEditingController();

  String? groupcourse;
  List<Course>? courses;
  String? groupyearstd;
  List<Year_Std>? years;
  List checkTeam = [];
  List<Drink>? teams;

  List<ListItem>? types = ListItem.getItem();
  late List<DropdownMenuItem<ListItem>> _dropdownMenuItem;
  late ListItem _selectedTypeItem;

  @override
  void initState() {
    super.initState();
    courses = Course.getcourse();
    years = Year_Std.getYear_Std();
    teams = Drink.getteam();
    _dropdownMenuItem = createDropdownMenuItem(types!);
    _selectedTypeItem = _dropdownMenuItem[0].value!;
    // print(foods);
  }

  List<DropdownMenuItem<ListItem>> createDropdownMenuItem(
      List<ListItem> types) {
    List<DropdownMenuItem<ListItem>> items = [];

    for (var item in types) {
      items.add(DropdownMenuItem(
        child: Text(item.name!),
        value: item,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Input Widget')),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '--- Information ---',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              usernameTextFormField(),
              passwordTextFormField(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Column(
                  children: createRadioYear(),
                ),
              ),
              line2(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Column(
                  children: createRadioCourse(),
                ),
              ),
              line2(),
              const SizedBox(height: 16),
              DropdownButton(
                value: _selectedTypeItem,
                items: _dropdownMenuItem,
                onChanged: (ListItem? value) {
                  setState(() {
                    _selectedTypeItem = value!;
                  });
                },
              ),
              line(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '--- เครื่องดื่มที่ชอบ ---',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: createCheckboxTeam(),
                ),
              ),
              SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Center dropdown() {
    return Center(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
          child: DropdownButton(
            items: _dropdownMenuItem,
            value: _selectedTypeItem,
            onChanged: (ListItem? value) {
              setState(() {
                _selectedTypeItem = value!;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget SubmitButton() {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print(_username.text);
          }
        },
        child: Text('Submit'),
      ),
    );
  }

  Widget usernameTextFormField() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: TextFormField(
          style: TextStyle(color: Colors.purple),
          controller: _username,
          validator: (vaLue) {
            if (vaLue!.isEmpty) {
              return "please enter your name";
            }
            return null;
          },
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: 'name',
              prefixIcon: Icon(Icons.vpn_key),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              )),
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        obscureText: true,
        obscuringCharacter: '*',
        controller: _pasword,
        validator: (vaLue) {
          if (vaLue!.isEmpty) {
            return "please enter your ID";
          }
          return null;
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            labelText: 'ID',
            prefixIcon: Icon(Icons.vpn_key),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
            )),
      ),
    );
  }

  List<Widget> createRadioCourse() {
    List<Widget> listCourse = [];
    for (var course in courses!) {
      listCourse.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: RadioListTile<dynamic>(
              title: Text(
                course.thname!,
              ),
              value: course.coursevalue!,
              groupValue: groupcourse,
              onChanged: (value) {
                setState(() {
                  groupcourse = value;
                });
              },
            ),
          ),
        ),
      );
    }
    return listCourse;
  }

  List<Widget> createRadioYear() {
    List<Widget> listYear = [];

    for (var year in years!) {
      listYear.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: RadioListTile<dynamic>(
              title: Text(
                year.year!,
              ),
              value: year.yearValue!,
              groupValue: groupyearstd,
              onChanged: (value) {
                setState(() {
                  groupyearstd = value;
                });
              },
            ),
          ),
        ),
      );
    }
    return listYear;
  }

  List<Widget> createCheckboxTeam() {
    List<Widget> listTeam = [];
    for (var team in teams!) {
      listTeam.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            child: CheckboxListTile(
              value: team.checked,
              title: Text(team.teamname!),
              // subtitle: Text('${drink.price} บาท'),
              onChanged: (value) {
                setState(() {
                  team.checked = value;
                });
                if (value!) {
                  checkTeam.add(team.teamname);
                } else {
                  checkTeam.remove(team.teamname);
                }
              },
            ),
          ),
        ),
      );
    }
    return listTeam;
  }
}

class ListItem {
  int? value;
  String? name;

  ListItem(this.value, this.name);

  static getItem() {
    return [
      ListItem(1, 'คณะวิทยาศาสตร์'),
      ListItem(2, 'คณะนิติศาสตร์'),
      ListItem(3, 'คณะวิทยาการสุขภาพและการกีฬา'),
      ListItem(4, 'คณะเทคโนโลยีและการพัฒนาชุมชน'),
      ListItem(5, 'คณะวิศวกรรมศาสตร์'),
      ListItem(6, 'คณะพยาบาลศาสตร์'),
      ListItem(7, 'คณะอุตสาหกรรมเกษตรและชีวภาพ'),
    ];
  }

  // void add(DropdownMenuItem dropdownMenuItem) {}
}

Widget line() => Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Divider(color: Colors.grey.shade600, thickness: 2),
          )),
        ],
      ),
    );

Widget line2() => Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Divider(color: Colors.grey.shade500, thickness: 1),
          )),
        ],
      ),
    );