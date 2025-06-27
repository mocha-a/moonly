import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedule/controller/calendar_controller.dart';
import 'package:schedule/controller/moon_icon.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  @override
  State<CalendarPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CalendarPage> {
  final controller = Get.find<SheduleConteroller>(); //Get 사용

  final formkey = GlobalKey<FormState>();
  String? title;
  String? content;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  Color selectedColor = Color.fromRGBO(235, 217, 255, 1);

  final List<Color> colorOptions = [
    Color.fromRGBO(235, 217, 255, 1),
    Color.fromRGBO(253, 240, 185, 1),
    Color.fromRGBO(222, 248, 244, 1),
    Color.fromRGBO(253, 218, 227, 1),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.loadSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          controller.list.length;
          return TableCalendar(
            headerStyle: HeaderStyle(formatButtonVisible: false),
            focusedDay: controller.selectedDate.value,
            //Obx를 사용할 때는 반드시 Rx 값을 화면에 렌더링에 사용하는 방식으로 포함
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            onDaySelected: (day, focusedDay) => controller.changeDate(day),
            selectedDayPredicate: (day) {
              return isSameDay(
                day,
                controller.selectedDate.value,
              ); // isSameDay: 2개의 값을 비교하여 같은 값만 true로 줌
            },
            eventLoader: (day) {
              String key = '${day.year}-${day.month}-${day.day}';
              var boxGet = controller.box.get(key, defaultValue: []);
              return boxGet;
            },
            calendarStyle: CalendarStyle(
              markersMaxCount: 2,

              // 오늘 날짜 배경색
              todayDecoration: BoxDecoration(
                color: Color.fromRGBO(252, 245, 191, 1),
                shape: BoxShape.circle,
              ),

              // 선택된 날짜 배경색
              selectedDecoration: BoxDecoration(
                color: Color.fromRGBO(219, 217, 240, 1),
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(color: Colors.black),
              selectedTextStyle: TextStyle(color: Colors.white),
            ),
            calendarBuilders: CalendarBuilders(
              //일요일, 토요일, 평일 Day 색
              defaultBuilder: (context, day, focusedDay) {
                final isSunday = day.weekday == DateTime.sunday;
                final isSaturday = day.weekday == DateTime.saturday;

                return Center(
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: isSunday
                          ? const Color.fromARGB(255, 255, 175, 175)
                          : isSaturday
                          ? const Color.fromARGB(255, 183, 190, 253)
                          : Colors.black,
                    ),
                  ),
                );
              },
              //일요일, 토요일, 평일 month 색
              dowBuilder: (context, day) {
                final text = DateFormat.E().format(day); // "일", "월", ...
                final isSunday = day.weekday == DateTime.sunday;
                final isSaturday = day.weekday == DateTime.saturday;

                return Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isSunday
                          ? const Color.fromRGBO(255, 102, 102, 1)
                          : isSaturday
                          ? const Color.fromRGBO(136, 148, 255, 1)
                          : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
              markerBuilder: (context, date, events) {
                if (events.isEmpty) return null;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: events.take(2).map((event) {
                    final colorValue = (event as Map)['color'] as int;
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 0.5,
                        vertical: 1,
                      ),
                      width: 30,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Color(colorValue),
                        shape: BoxShape.rectangle, // 사각형으로 설정
                        borderRadius: BorderRadius.circular(10), // 둥글게
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            // selectedDayPredicate: , => 선택한 일자에 포커스 색상 발생
            // onDaySelected: , => 일자를 선택하면 change이벤트 발생
            // eventLoader: , => 등록된 내용을 달력에 표시
          );
        }),
        SizedBox(height: 20),
        Obx(() {
          // 선택된 날짜의 일정만 가져오기
          var allList = List<Map>.from(controller.list);

          // 시간별로 정렬
          allList.sort(
            (a, b) => (a['startTime'] as DateTime).compareTo(
              b['startTime'] as DateTime,
            ),
          );

          // 시간 그룹 만들기
          Map<String, List<Map>> grouped = {};
          for (var item in allList) {
            String hour = (item['startTime'] as DateTime).hour
                .toString()
                .padLeft(2, '0');
            grouped.putIfAbsent(hour, () => []).add(item);
          }
          return Expanded(
            child: Stack(
              children: [
                grouped.isEmpty
                    ? SizedBox.expand(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/no_data.svg'),
                            SizedBox(height: 20),
                            Text(
                              '오늘은 조용하네요\n빛나는 일정을 추가해봐요✨',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        children: grouped.entries.map((entry) {
                          String hour = entry.key;
                          List<Map> events = entry.value;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      DateFormat.jm().format(
                                        DateTime(
                                          0,
                                          1,
                                          1,
                                          int.parse(hour),
                                        ), // hour → "08", "15" 등
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // 일정들
                              ...events.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 28),
                                        child: Text(
                                          (item['startTime'].hour == 0 &&
                                                  item['startTime'].minute == 0)
                                              ? '00:00'
                                              : DateFormat(
                                                  'HH:mm',
                                                ).format(item['startTime']),
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          onTap: () {
                                            controller.alertDialog(
                                              context,
                                              item,
                                            );
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color(item['color']),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: ListTile(
                                                  title: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      MoonIcon(size: 20),
                                                      SizedBox(width: 12),
                                                      Text(item['title']),
                                                    ],
                                                  ),
                                                  subtitle: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          left: 32,
                                                        ),
                                                    child: Text(
                                                      item['content'],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  tileColor: Colors.transparent,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8,
                                                      ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                child: IconButton(
                                                  onPressed: () {
                                                    controller.deleteSchedule(
                                                      item['time'],
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.close_rounded,
                                                  ),
                                                  iconSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          );
                        }).toList(),
                      ),
                Positioned(
                  right: 24,
                  bottom: 24,
                  child: IconButton(
                    onPressed: () {
                      addForm(context);
                    },
                    icon: Icon(Icons.add),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.pink[100],
                      foregroundColor: Colors.white,
                      iconSize: 20,
                      padding: EdgeInsets.all(15),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  //일정 추가
  void addForm(dynamic context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, // 키보드 높이만큼 패딩
              ),
              child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Wrap(
                          spacing: 8,
                          children: colorOptions.map((color) {
                            return GestureDetector(
                              onTap: () {
                                setModalState(() {
                                  selectedColor = color;
                                });
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedColor == color
                                        ? const Color.fromARGB(255, 99, 99, 99)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.input,
                                );
                                if (picked != null) {
                                  setModalState(() {
                                    startTime = picked;
                                  });
                                } // 새로고침
                              },
                              child: Text(
                                startTime != null
                                    ? startTime!.format(context)
                                    : '시작 시간',
                              ),
                            ),
                            Text(
                              '-',
                              style: TextStyle(
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.input,
                                );
                                if (picked != null) {
                                  setModalState(() {
                                    endTime = picked;
                                  });
                                }
                              },
                              child: Text(
                                endTime != null
                                    ? endTime!.format(context)
                                    : '종료 시간',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            // TextField() => 유효성 검사를 못해욤
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                //value.isEmpty : value의 값이 비어있는지 체꾸체꾸
                                return '내용을 입력해 주세요';
                              }
                              return null; //내가 작성한 글이 value값에 다 다들어오고 유효성 검사
                            },
                            decoration: InputDecoration(labelText: 'title'),
                            onSaved: (value) {
                              title = value;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                //value.isEmpty : value의 값이 비어있는지 체꾸체꾸
                                return '내용을 입력해 주세요';
                              }
                              return null; //내가 작성한 글이 value값에 다 다들어오고 유효성 검사
                            },
                            decoration: InputDecoration(labelText: 'content'),
                            onSaved: (value) {
                              content = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        DateTime startDateTime = DateTime(
                          controller.selectedDate.value.year,
                          controller.selectedDate.value.month,
                          controller.selectedDate.value.day,
                          startTime?.hour ?? 0,
                          startTime?.minute ?? 0,
                        );

                        DateTime endDateTime = DateTime(
                          controller.selectedDate.value.year,
                          controller.selectedDate.value.month,
                          controller.selectedDate.value.day,
                          endTime?.hour ?? 0,
                          endTime?.minute ?? 0,
                        );

                        if (formkey.currentState!.validate()) {
                          //유효성 검사를 마치고 난 후 성공했으면 true값을 줌
                          formkey.currentState!.save();
                          //form에 모든 값들이 저장
                          //!.save() : save가 무조건 존재한다는 의미로 ! 사용
                          controller.addSchedule(
                            title!,
                            content!,
                            startDateTime,
                            endDateTime,
                            selectedColor.toARGB32(),
                          );
                          //위에 type에 ?를 넣어서 null, string 중에 하나의 값이 들어오는데 어떤 값이 들어오는지 몰라서 !로 무조건 string이 들어올것 이라는 걸 알려줌
                          Navigator.pop(context);
                        }
                      },
                      child: Text('일정 추가'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
