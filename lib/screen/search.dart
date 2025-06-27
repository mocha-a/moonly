import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:schedule/controller/calendar_controller.dart';
import 'package:schedule/controller/moon_icon.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Search> {
  final controller = Get.find<SheduleConteroller>();
  final TextEditingController _searchController = TextEditingController();
  String query = '';
  List<dynamic> list = [];
  List<String> recentSearch = []; //최근검색어

  late Box<String> recentSearchBox;

  @override
  void initState() {
    super.initState();
    recentSearchBox = Hive.box<String>('recentSearchBox');
    // Hive에 저장된 최근검색어 불러오기
    recentSearch = recentSearchBox.values.toList().reversed.toList();
  }

  //랜더링 할때 한번만 실행 useEffect() 같은 것 !
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.loadSchedule();
  }

  void search(String query) {
    var all = controller.all;
    var filterData = all
        .where(
          (item) =>
              item['value']['title'].contains(query) ||
              item['value']['content'].contains(query),
        )
        .toList();

    setState(() {
      list = filterData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: SearchBar(
                controller: _searchController,
                hintText: '찾고 있는 일정이 있나요 ?',
                onSubmitted: (value) {
                  search(value);
                  setState(() {
                    query = value;
                  });
                  addRecentSearch(value);
                },
                elevation: WidgetStateProperty.all(0),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.transparent), // 테두리 없앰
                  ),
                ),
                trailing: [
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        query = '';
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('최근 검색어'),
                  SizedBox(height: 8), // 텍스트 아래 여백
                  SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: recentSearch.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () async {
                                await addRecentSearch(
                                  item,
                                ); // item을 다시 추가해서 맨 앞으로 보냄
                                _searchController.text = item;
                                search(item);
                                setState(() {
                                  query = item;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ), // 내부 여백
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromRGBO(171, 165, 220, 1),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(item, overflow: TextOverflow.ellipsis),
                                    SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () async {
                                        // Hive에서 삭제하는 비동기 작업 먼저 수행
                                        final deleteKeys = recentSearchBox.keys
                                            .where(
                                              (key) =>
                                                  recentSearchBox.get(key) ==
                                                  item,
                                            )
                                            .toList();

                                        for (var key in deleteKeys) {
                                          await recentSearchBox.delete(key);
                                        }

                                        // Hive에서 삭제 끝나면, 최근 검색어 리스트 다시 불러와서 setState
                                        setState(() {
                                          recentSearch = recentSearchBox.values
                                              .toList()
                                              .reversed
                                              .toList();
                                        });
                                      },
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: list.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/no_data.svg'),
                      SizedBox(height: 20),
                      Text(
                        query.isEmpty ? '검색어를 입력해주세요 !' : '검색 결과가 없습니다 !',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var item = list[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Color(item['value']['color']),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MoonIcon(size: 20),
                              SizedBox(width: 10),
                              Text(
                                ' ${item['value']['title']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 32),
                            child: Text(
                              item['value']['startTime'].hour == 0 &&
                                      item['value']['startTime'].minute == 0 &&
                                      item['value']['endTime'].hour == 0 &&
                                      item['value']['endTime'].minute == 0
                                  ? '하루종일'
                                  : '${DateFormat('HH:mm').format(item['value']['startTime'])} ~ ${DateFormat('HH:mm').format(item['value']['endTime'])}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          onTap: () {
                            controller.alertDialog(context, item['value']);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // 최근 검색어 Box 저장 함수
  Future<void> addRecentSearch(String value) async {
    if (value.isEmpty) return;

    // 중복 값 있으면 삭제
    final existingKey = recentSearchBox.keys.firstWhere(
      (key) => recentSearchBox.get(key) == value,
      orElse: () => null,
    );

    if (existingKey != null) {
      await recentSearchBox.delete(existingKey);
    }

    // 최대 10개 유지 (삭제 후 다시 추가하기 때문에 10개 초과일 수도)
    while (recentSearchBox.length >= 10) {
      await recentSearchBox.deleteAt(0); // 가장 오래된 값 삭제
    }

    await recentSearchBox.add(value);

    setState(() {
      recentSearch = recentSearchBox.values.toList().reversed.toList();
    });
  }
}
