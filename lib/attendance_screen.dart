import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zucol_assignment/models/attendance_model.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> with TickerProviderStateMixin {
  CalendarFormat _calenderFormat = CalendarFormat.week;
  DateTime focusDay = DateTime.now();
  List<int>? daysOfWeek = [6,7];
  int presentDays = 04;
  int absentDays = 01;
  int percentageWeek = 90;
  int percentageMonth = 90;
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    TabController tabViewController = TabController(length: 2, vsync: this);
    //int workingDays = presentDays + absentDays;
    //double attendancePercentage = (presentDays / workingDays) * 100;
    return Scaffold(
      appBar: AppBar(
        //elevation: 1,
        title:  Row(
          children: [
            GestureDetector(
              onTap: (){},
              child: SvgPicture.asset(
                'assets/svgs/backArrow.svg',
                // semanticsLabel: 'Arrow',
                height: 40,
                width: 40,
              ),
            ),
            const SizedBox(width: 10),
            const Text("Attendance",style: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            bannerWidget(),
            // Padding(
            //   padding: const EdgeInsets.all(15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Row(
            //         children: [
            //           const Text("January",style: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold,fontSize: 18),),
            //           const SizedBox(width: 5),
            //           SvgPicture.asset(
            //             alignment: Alignment.center,
            //             'assets/svgs/dropDown.svg',
            //             // semanticsLabel: 'Dropdown',
            //             height: 20,
            //             width: 20,
            //           ),
            //         ],
            //       ),
            //       SvgPicture.asset(
            //         'assets/svgs/calendar.svg',
            //         // semanticsLabel: 'Calendar',
            //         height: 30,
            //         width: 30,
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 15),
            calenderWidget(),
            const Padding(
              padding: EdgeInsets.only(left: 15,right: 15,top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Ruchika's Presence",
                    style: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                ],
              ),
            ),
            tabBarWidget(tabViewController),
            const Padding(
              padding: EdgeInsets.only(left: 15,right: 15,top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Attendance Details",
                    style: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: attendanceList.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    // height: 170,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color(0xffF9F9F9),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${attendanceList[index].day} ${attendanceList[index].date}",style: const TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold,fontSize: 14),),
                            SvgPicture.asset(
                              'assets/svgs/check.svg',
                              // semanticsLabel: 'Check',
                              height: 30,
                              width: 30,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(textAlign: TextAlign.start,
                              attendanceList[index].arrivalStatus,style: const TextStyle(fontFamily: 'Quicksand',fontSize: 14),),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Dropped by - ${attendanceList[index].droppedBy}",style: const TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold,fontSize: 14,color: Color(0xff9C9C9C)),),
                            Text("- ${attendanceList[index].date}",style: const TextStyle(fontFamily: 'Quicksand',fontSize: 14,color: Color(0xff9C9C9C)),),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Picked up by - ${attendanceList[index].pickedUpBy}",style: const TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold,fontSize: 14,color: Color(0xff9C9C9C)),),
                            Text("- ${attendanceList[index].date}",style: const TextStyle(fontFamily: 'Quicksand',fontSize: 14,color: Color(0xff9C9C9C)),),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Flexible(flex: 4, child: Text("Dropped by - ${attendanceList[index].droppedBy}",style: const TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold,fontSize: 14,color: Color(0xff9C9C9C)),)),
                        //     Flexible(flex: 2,child: Text("- ${attendanceList[index].date}",style: const TextStyle(fontFamily: 'Quicksand',fontSize: 14,color: Color(0xff9C9C9C)),)),
                        //   ],
                        // ),
                        // const SizedBox(height: 8),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Flexible(flex: 4,child: Text("Picked up by - ${attendanceList[index].pickedUpBy}",style: const TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold,fontSize: 14,color: Color(0xff9C9C9C)),)),
                        //     Flexible(flex: 2,child: Text("- ${attendanceList[index].date}",style: const TextStyle(fontFamily: 'Quicksand',fontSize: 14,color: Color(0xff9C9C9C)),)),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                );
              },),
          ],
        ),
      ),
    );
  }

  Widget bannerWidget(){
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xffDEF5FF),
          borderRadius: BorderRadius.circular(30),
          image:  const DecorationImage(
              image: AssetImage("assets/images/turtle.png"),
              alignment: Alignment.bottomRight),
        ),
        child:  const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Yay! Ruchika is present today",style: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget calenderWidget(){
    return Container(
      padding: const EdgeInsets.only(left: 10,right: 10),
      //height: 160,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TableCalendar(

        focusedDay: focusDay,
        firstDay: DateTime(1994),
        lastDay: DateTime(2030),
        calendarFormat: _calenderFormat,
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekHeight: 50,
        //headerVisible: false,
        enabledDayPredicate: (DateTime dateTime) => !daysOfWeek!.contains(dateTime.weekday),
        headerStyle: HeaderStyle(
          // decoration: const BoxDecoration(
          //   color: Colors.white,
          //   image: DecorationImage(
          //       image: AssetImage("assets/images/check.png"),
          //       alignment: Alignment.bottomRight),
          // ),
          titleTextStyle: const TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold,fontSize: 18),
          formatButtonTextStyle: const TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold,fontSize: 16),
          leftChevronVisible: false,
          rightChevronVisible: false,
          headerPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          titleTextFormatter: (date, locale) =>
              DateFormat.MMMM(locale).format(date),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextFormatter: (date, locale) =>
          DateFormat.E(locale).format(date)[0],
          weekendStyle: const TextStyle(color: Colors.red),
        ),
        weekendDays: const [DateTime.saturday, DateTime.sunday],
        calendarStyle: const CalendarStyle(
            defaultTextStyle: TextStyle(fontWeight: FontWeight.bold),
            canMarkersOverflow: true,
            markerSize: 10,
            weekendTextStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
            selectedDecoration: BoxDecoration(
              color: Color(0xffCB89EA),
              shape: BoxShape.circle,
            )),
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            _selectedDay = selectedDay;
            focusDay = focusedDay;
            setState(() {});
          }
        },
        selectedDayPredicate: (DateTime day) {
          return isSameDay(_selectedDay, day);
        },
        onFormatChanged: (format) {
          if (_calenderFormat != format) {
            setState(() {
              _calenderFormat = format;
            });
          }
        },
      ),
    );
  }

  Widget tabBarWidget(TabController tabViewController){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TabBar(
              labelColor: Colors.black,
              labelStyle: const TextStyle(fontFamily: 'Quicksand',fontWeight: FontWeight.bold,fontSize: 16),
              controller: tabViewController,
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: "This Week"),
                Tab(text: "This Month"),
              ]),
        ),
        SizedBox(
          height: 150,
          child: TabBarView(controller: tabViewController, children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xffA0DFFA),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    runAlignment: WrapAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Present",
                                style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45),
                              ),
                              Text(
                                presentDays.toString(),
                                style: const TextStyle(fontFamily: 'Quicksand',fontSize: 24,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 45,
                            child: VerticalDivider(
                              thickness: 1.5,
                              color: Colors.black54,
                            ),
                          ),
                          Column(
                            children: [
                              const Text(
                                "Absent",
                                style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45),
                              ),
                              Text(
                                absentDays.toString(),
                                style: const TextStyle(fontFamily: 'Quicksand',fontSize: 24,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 45,
                            child: VerticalDivider(
                              thickness: 1.5,
                              color: Colors.black54,
                            ),
                          ),
                          Column(
                            children: [
                              const Text(
                                "Percentage",
                                style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45),
                              ),
                              Text(
                                "$percentageWeek %",
                                style: const TextStyle(fontFamily: 'Quicksand',fontSize: 24,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xffA0DFFA),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    runAlignment: WrapAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Present",
                                style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45),
                              ),
                              Text(
                                presentDays.toString(),
                                style: const TextStyle(fontFamily: 'Quicksand',fontSize: 24,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 45,
                            child: VerticalDivider(
                              thickness: 1.5,
                              color: Colors.black54,
                            ),
                          ),
                          Column(
                            children: [
                              const Text(
                                "Absent",
                                style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45),
                              ),
                              Text(
                                absentDays.toString(),
                                style: const TextStyle(fontFamily: 'Quicksand',fontSize: 24,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 45,
                            child: VerticalDivider(
                              thickness: 1.5,
                              color: Colors.black54,
                            ),
                          ),
                          Column(
                            children: [
                              const Text(
                                "Percentage",
                                style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45),
                              ),
                              Text(
                                "$percentageMonth %",
                                style: const TextStyle(fontFamily: 'Quicksand',fontSize: 24,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
