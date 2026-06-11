import 'package:flutter/material.dart';
import 'package:kelompok2/logic/jadwal_logic.dart';
import 'login_page.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int currentIndex = 1;

  String selectedSemester = "Semester 4";
  String selectedDay = "Senin";


  Widget statCard(String value, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Color cardColor(String type) {
    switch (type) {
      case "LECTURE":
        return Colors.blue;

      case "SEMINAR":
        return Colors.green;

      case "LAB":
        return Colors.orange;

      case "PRAKTIKUM":
        return Colors.deepPurple;

      case "TEORI":
        return Colors.indigo;

      default:
        return Colors.teal;
    }
  }

  Widget dayButton(String day) {
    bool selected = selectedDay == day;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDay = day;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          gradient: selected
              ? const LinearGradient(
            colors: [
              Color(0xFF2563EB),
              Color(0xFF7C3AED),
            ],
          )
              : null,
          color: selected ? null : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          day,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void addScheduleDialog() {
    final course = TextEditingController();
    final lecturer = TextEditingController();
    final room = TextEditingController();
    final time = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Tambah Jadwal"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: course,
                decoration: const InputDecoration(
                  labelText: "Mata Kuliah",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: lecturer,
                decoration: const InputDecoration(
                  labelText: "Dosen",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: room,
                decoration: const InputDecoration(
                  labelText: "Ruangan",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: time,
                decoration: const InputDecoration(
                  labelText: "Jam",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              ScheduleLogic.addSchedule(
                selectedSemester,
                selectedDay,
                Schedule(
                  course: course.text,
                  lecturer: lecturer.text,
                  room: room.text,
                  time: time.text,
                  type: "CUSTOM",
                ),
              );

              setState(() {});

              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  Widget homePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
        Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2563EB),
              Color(0xFF7C3AED),
            ],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat Datang 👋",
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "UniSched",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Aplikasi Jadwal Kuliah Mahasiswa",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 20),

      Card(
        child: ListTile(
          leading: const Icon(Icons.school),
          title: const Text("Semester Aktif"),
          subtitle: Text(selectedSemester),
        ),
      ),

      Card(
        child: ListTile(
          leading: const Icon(Icons.book),
          title: const Text("Jumlah Mata Kuliah"),
          subtitle: Text(
            ScheduleLogic.totalCourses(
              selectedSemester,
            ).toString(),
          ),
        ),
      ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text("Hari Kuliah"),
              subtitle: Text(
                ScheduleLogic.totalDays(
                  selectedSemester,
                ).toString(),
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.credit_score),
              title: const Text("Total SKS"),
              subtitle: Text(
                ScheduleLogic.totalSKS(
                  selectedSemester,
                ).toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profilePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 30),

          const CircleAvatar(
            radius: 60,
            backgroundColor: Color(0xFF2563EB),
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            "MANUSIA",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Text(
            "Teknik Informatika",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 25),

          Card(
            child: ListTile(
              leading: const Icon(Icons.badge),
              title: const Text("NIM"),
              subtitle: const Text("221011401234"),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: const Text(
                "deya@email.com",
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.school),
              title: const Text("Program Studi"),
              subtitle: const Text(
                "Teknik Informatika",
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text("Semester Aktif"),
              subtitle: Text(selectedSemester),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                "Keluar dari aplikasi",
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text(
                      "Apakah Anda yakin ingin keluar?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Batal"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);

                          // Keluar aplikasi
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget schedulePage() {
    final schedules =
    ScheduleLogic.schedules[selectedSemester]![selectedDay]!;

    return SafeArea(
      child: Column(
          children: [
      Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2563EB),
            Color(0xFF4F46E5),
            Color(0xFF7C3AED),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(50),
                ),
                child: const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.school,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ),

              const SizedBox(width: 15),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "UniSched",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Jadwal Kuliah Mahasiswa",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: statCard(
                  ScheduleLogic
                      .totalCourses(
                      selectedSemester)
                      .toString(),
                  "Matkul",
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: statCard(
                  ScheduleLogic
                      .totalDays(
                      selectedSemester)
                      .toString(),
                  "Hari",
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: statCard(
                  ScheduleLogic
                      .totalSKS(
                      selectedSemester)
                      .toString(),
                  "SKS",
                ),
              ),
            ],
          ),
        ],
      ),
    ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.school,
                            color: Color(0xFF2563EB),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Semester 4",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          dayButton("Senin"),
                          dayButton("Selasa"),
                          dayButton("Rabu"),
                          dayButton("Kamis"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: ListView.builder(
                        itemCount: schedules.length,
                        itemBuilder: (context, index) {
                          final item = schedules[index];

                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 15,
                            ),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(20),
                              border: Border.all(
                                color: cardColor(item.type),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: cardColor(item.type)
                                        .withOpacity(0.15),
                                    borderRadius:
                                    BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Text(
                                    item.type,
                                    style: TextStyle(
                                      color:
                                      cardColor(item.type),
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Text(
                                  item.course,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  "👨‍🏫 ${item.lecturer}",
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  "🏫 ${item.room}",
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  "🕒 ${item.time}",
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      homePage(),
      schedulePage(),
      profilePage(),
    ];

    return Scaffold(
      body: pages[currentIndex],

      floatingActionButton: currentIndex == 1
          ? Container(
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2563EB),
              Color(0xFF7C3AED),
            ],
          ),
        ),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: addScheduleDialog,
          icon: const Icon(Icons.add),
          label: const Text(
            "Tambah Jadwal",
          ),
        ),
      )
          : null,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        selectedItemColor:
        const Color(0xFF2563EB),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Jadwal",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}