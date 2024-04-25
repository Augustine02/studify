import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studify/widgets/reusable_textbutton.dart';
import 'courseList_screen.dart';
import 'package:studify/views/test.dart';

class ChoiceOfDepartmentScreen extends StatefulWidget {
  const ChoiceOfDepartmentScreen({Key? key}) : super(key: key);

  @override
  State<ChoiceOfDepartmentScreen> createState() => _ChoiceOfDepartmentScreenState();
}

class _ChoiceOfDepartmentScreenState extends State<ChoiceOfDepartmentScreen> {

  List<String> items = ['Computer Science', 'Mathematics', 'Pure & Industrial Chemistry', 'Physics'];
  List<String> years = ['First Year', 'Second Year', 'Third Year', 'Fourth Year', 'Final Year'];
  List<String> semesters = ['First Semester', 'Second Semester'];
  String? selectedDepartment ;
  String? selectedSemester ;
  String? selectedYear ;

  DropdownButton<String> departmentDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String item in items) {
      var newItem = DropdownMenuItem(
        child: Text(item),
        value: item,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      hint: Text('Select your department',style: TextStyle(fontSize: 14, color: Colors.black26),),
      iconEnabledColor: Colors.greenAccent,
      isExpanded: true,
      dropdownColor: Colors.white,
      value: selectedDepartment,
      // isExpanded: true,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedDepartment = value;
        });
      },
    );
  }
  DropdownButton<String> yearDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String year in years) {
      var newItem = DropdownMenuItem(
        child: Text(year),
        value: year,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      hint: Text('Select your year',style: TextStyle(fontSize: 14, color: Colors.black26),),
      iconEnabledColor: Colors.greenAccent,
      isExpanded: true,
      dropdownColor: Colors.white,
      value: selectedYear,
      // isExpanded: true,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedYear = value;
        });
      },
    );
  }
  DropdownButton<String> semesterDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String semester in semesters) {
      var newItem = DropdownMenuItem(
        child: Text(semester),
        value: semester,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      isExpanded: true,
      hint: Text('Select semester',style: TextStyle(fontSize: 14, color: Colors.black26),),
      iconEnabledColor: Colors.greenAccent,
      dropdownColor: Colors.white,
      value: selectedSemester,
      // isExpanded: true,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedSemester = value;
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0F4206),
      body: Container(
        padding: EdgeInsets.only(top: 100, left: 30, right: 30, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: (){Get.back();},
                    icon: Icon(Icons.chevron_left_rounded, color: Colors.white, size: 50,)),
                SizedBox(height: 30),
                Text('Choose your\nDepartment',
                    style: GoogleFonts.inika(
                        textStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600)
                    )
                ),
              ],
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: departmentDropdown()),
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: yearDropdown()),
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: semesterDropdown()),
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ReusableTextButton(
                  title: 'Continue',
                  textColor: Color(0xFF0F4206),
                  color: Colors.white,
                  onPress: (){
                    Get.to(() => CourseListScreen(
                      department: selectedDepartment,
                      year: selectedYear,
                      semester: selectedSemester,
                    ));
                  },
                ),
              ),
            )
          ],
        ),
      ));
  }
}
