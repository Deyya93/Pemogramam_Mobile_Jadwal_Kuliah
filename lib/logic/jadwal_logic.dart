class Schedule {
  String course;
  String lecturer;
  String room;
  String time;
  String type;

  Schedule({
    required this.course,
    required this.lecturer,
    required this.room,
    required this.time,
    required this.type,
  });
}

class ScheduleLogic {
  static Map<String, Map<String, List<Schedule>>> schedules = {
    "Semester 4": {
      "Senin": [
        Schedule(
          course: "Pemrograman Web Lanjut",
          lecturer: "Dr. Ahmad Subagyo",
          room: "Gedung B R302",
          time: "08:00 - 09:40",
          type: "LECTURE",
        ),
        Schedule(
          course: "Rekayasa Perangkat Lunak",
          lecturer: "Bambang, M.Kom",
          room: "R303",
          time: "13:00 - 14:40",
          type: "LECTURE",
        ),
      ],

      "Selasa": [
        Schedule(
          course: "Kecerdasan Buatan",
          lecturer: "Ir. Sarah Wijaya",
          room: "Lab Komputer",
          time: "10:00 - 11:40",
          type: "SEMINAR",
        ),
      ],

      "Rabu": [
        Schedule(
          course: "Jaringan Komputer",
          lecturer: "Budi Santoso",
          room: "Lab Networking",
          time: "08:00 - 09:40",
          type: "LAB",
        ),
        Schedule(
          course: "Interaksi Manusia dan Komputer",
          lecturer: "Rina, M.Kom",
          room: "R204",
          time: "13:00 - 14:40",
          type: "LECTURE",
        ),
      ],

      "Kamis": [
        Schedule(
          course: "Pemrograman Mobile",
          lecturer: "Andri, M.Kom",
          room: "Lab Flutter",
          time: "08:00 - 09:40",
          type: "PRAKTIKUM",
        ),
      ],
    },
  };

  static void addSchedule(
      String semester,
      String day,
      Schedule schedule,
      ) {
    schedules[semester]![day]!.add(schedule);
  }

  static int totalCourses(String semester) {
    int total = 0;

    schedules[semester]!.forEach((day, list) {
      total += list.length;
    });

    return total;
  }

  static int totalDays(String semester) {
    return schedules[semester]!.length;
  }

  static int totalSKS(String semester) {
    return 22;
  }
}