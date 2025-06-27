import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedule/controller/calendar_controller.dart';
import 'package:schedule/controller/moon_icon.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  final controller = Get.find<SheduleConteroller>();

  //랜더링 할때 한번만 실행 useEffect() 같은 것 !
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadSchedule();
    });
  }

  Map<String, List<Map<String, dynamic>>> groupByDate(List<dynamic> items) {
    Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var item in items) {
      String key = item['key'];
      Map<String, dynamic> value = Map<String, dynamic>.from(item['value']);

      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(value);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int allLength = controller.all.length;
      var allList = controller.all;
      var grouped = groupByDate(allList);
      var keys = grouped.keys.toList();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style, // 기본 스타일 지정
                  children: [
                    TextSpan(text: '총 ', style: TextStyle(fontSize: 14)),
                    TextSpan(
                      text: '$allLength',
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: ' 개의 일정 발견 !',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: keys.isEmpty
                  ? SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/no_data.svg'),
                          SizedBox(height: 20),
                          Text(
                            '오늘은 조용하네요\n빛나는 일정 추가해봐요✨',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: keys.length,
                      itemBuilder: (context, index) {
                        String date = keys[index];
                        List<Map<String, dynamic>> values = grouped[date]!;
                        DateTime parsedDate;
                        List<String> parts = date.split('-');
                        parsedDate = DateTime(
                          int.parse(parts[0]),
                          int.parse(parts[1]),
                          int.parse(parts[2]),
                        );
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 날짜 타이틀
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat('MMM').format(parsedDate),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromRGBO(
                                              57,
                                              189,
                                              255,
                                              1,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          DateFormat('d').format(parsedDate),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ...values.asMap().entries.map((entry) {
                                          var item = entry.value;
                                          return Stack(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                  vertical: 5,
                                                ),
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
                                                      SizedBox(width: 8),
                                                      Text(
                                                        ' ${item['title']}',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          left: 30,
                                                        ),
                                                    child: Text(
                                                      item['startTime'].hour ==
                                                                  0 &&
                                                              item['startTime']
                                                                      .minute ==
                                                                  0 &&
                                                              item['endTime']
                                                                      .hour ==
                                                                  0 &&
                                                              item['endTime']
                                                                      .minute ==
                                                                  0
                                                          ? '하루종일'
                                                          : '${DateFormat('HH:mm').format(item['startTime'])} ~ ${DateFormat('HH:mm').format(item['endTime'])}',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8,
                                                      ),
                                                  onTap: () {
                                                    controller.alertDialog(
                                                      context,
                                                      item,
                                                    );
                                                  },
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
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // 날짜별 내용 리스트
                            Divider(), // 각 날짜 구분선
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      );
    });
  }
}
