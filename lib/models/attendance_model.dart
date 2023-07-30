class AttendanceModel {
   String pickedUpBy;
   String droppedBy;
   String pickedTime;
   String droppedTime;
   String arrivalStatus;
   String date;
   String day;

  AttendanceModel(
      {required this.pickedUpBy, required this.droppedBy, required this.pickedTime, required this.droppedTime, required this.date, required this.day, required this.arrivalStatus});

   Map<String, dynamic> toMap() {
    return {
      'pickedUpBy': pickedUpBy,
      'droppedBy': droppedBy,
      'pickedTime': pickedTime,
      'droppedTime': droppedTime,
      'arrivalStatus': arrivalStatus,
      'date': date,
      'day': day,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      pickedUpBy: map['pickedUpBy'] as String,
      droppedBy: map['droppedBy'] as String,
      pickedTime: map['pickedTime'] as String,
      droppedTime: map['droppedTime'] as String,
      arrivalStatus: map['arrivalStatus'] as String,
      date: map['date'] as String,
      day: map['day'] as String,
    );
  }
}

List<AttendanceModel> attendanceList = [
  AttendanceModel(pickedUpBy: "Mrs. Swati Patil", droppedBy: "Mr. Sunil Patil", pickedTime: "08:24am", droppedTime: "12:03pm", date: "08-03-2023", day: "Friday",arrivalStatus: "Arrived on time"),
  AttendanceModel(pickedUpBy: "Mrs. Swati Patil", droppedBy: "Mr. Sunil Patil", pickedTime: "08:24am", droppedTime: "12:03pm", date: "08-03-2023", day: "Friday",arrivalStatus: "Arrived on time"),
];