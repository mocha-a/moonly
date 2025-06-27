import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class SheduleConteroller extends GetxController {
  // RxList<Map<String, dynamic>> list = [{ 'key': '값' }].obs;
  var list = [].obs;
  var all = [].obs;
  var selectedDate = DateTime.now().obs;

  late Box box;

  @override
  //무조건 실행하는 함수
  void onInit() {
    super.onInit();
    box = Hive.box('scheduleBox');
    ever(selectedDate, (_) => loadSchedule());
    // ever: selectedDate의 값이 변경되면 (_) => {} 함수가 재실행한다 ! 옵저버?..같은것
    // selectedDate의 값이 변경 될때만 재실행 하기 때문에 처음 랜더링 될 수 있게 loadSchedule() 실행
    loadSchedule();
  }

  void loadSchedule() {
    var day = selectedDate.value;
    String key = '${day.year}-${day.month}-${day.day}';

    var boxGet = box.get(key, defaultValue: []); //기기(hive)에 저장된 값 가져오기
    list.assignAll(List.from(boxGet));
    //List.from(boxGet): 배열의 형태로 변환

    allSchedule();
  }

  //hive에 저장하는 함수
  void saveSchedule() {
    var day = selectedDate.value;
    String key = '${day.year}-${day.month}-${day.day}';
    box.put(key, list.toList());

    allSchedule();
  }

  //일정 추가 함수
  void addSchedule(
    String title,
    String content,
    DateTime startTime,
    DateTime endTime,
    int color,
  ) {
    var item = {
      'title': title,
      'content': content,
      'time': DateTime.now(),
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
    };

    list.add(item);

    saveSchedule();
  }

  //일정 삭제 함수
  void deleteSchedule(DateTime n) {
    list.removeWhere((item) => item['time'] == n);
    //removeWhere: filter랑 비슷한 녀석 ! 같은 것을 찾아서 지운당

    saveSchedule();
  }

  //날짜 선택 함수
  void changeDate(day) {
    selectedDate.value = day; //value 안에 날짜가 들어있음 !
  }

  void allSchedule() {
    all.assignAll(
      box.keys
          .where((key) => (box.get(key) as List).isNotEmpty)
          .expand(
            (key) => (box.get(key) as List).map(
              (item) => {'key': key, 'value': item},
            ),
          )
          .toList(),
    );
  }

  void alertDialog(BuildContext context, Map<dynamic, dynamic> value) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(value['title'], style: TextStyle(fontSize: 18)),
              Spacer(),
              Text(
                value['startTime'].hour == 0 &&
                        value['startTime'].minute == 0 &&
                        value['endTime'].hour == 0 &&
                        value['endTime'].minute == 0
                    ? '하루종일'
                    : '${DateFormat('HH:mm').format(value['startTime'])} ~ ${DateFormat('HH:mm').format(value['endTime'])}',
                style: TextStyle(fontSize: 12, color: Colors.pink),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value['content'], style: TextStyle(fontSize: 16)),
              SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.grey, fontSize: 12), // 기본 스타일
                  children: [
                    TextSpan(
                      text:
                          '${DateFormat('yyyy.MM.dd h:mma').format(value['time']).toLowerCase()} 에 작성 했어요 ',
                      style: TextStyle(
                        fontFamily: GoogleFonts.jua().fontFamily,
                      ),
                    ),
                    TextSpan(
                      text: '⋆⁺✧',
                      style: TextStyle(fontSize: 14), // 여기만 크기 키움
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
