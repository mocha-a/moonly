![Image](https://github.com/user-attachments/assets/b6ebd557-2066-4b73-9463-4934d919f617)

## 🌙 요약

#### 1. **주제**

- 사용자가 쉽고 빠르게 일정을 등록 · 관리할 수 있는 Flutter 기반 웹 일정 관리 앱

#### 2. **목표**

- 일정 시간별 구분과 정렬로 가독성 향상
- 색상별 그룹핑으로 일정 분류 편의성 증대
- 오프라인에서도 데이터 유지 가능한 로컬 저장 지원
- 효율적인 상태 관리로 원활한 사용자 경험 제공

#### 3. **개발 환경**

- Flutter, Dart, GetX, Hive

#### 4. **기간**

- 2025-06-10 ~ 2025-06-11 : 기획 및 디자인
- 2025-06-11 ~ 2025-06-16 : 개발
- 2025-06-16 : 테스트 및 배포

총 5일, 1인


## 🔗 배포 URL

- https://anji-moonly.vercel.app/


## 📌 주요 기능

- TableCalendar 기반 직관적인 달력 UI
- 시작 시간 기준 자동 정렬 및 시간대 구분선 표시
- 4가지 색상 그룹핑으로 일정 분류 및 시각화
- 일정 검색 기능
- GetX를 이용한 상태 관리
- Hive를 활용한 로컬 데이터 저장 (오프라인 지원)


## 💼 프로젝트 폴더 구조

```
📦moonly
 ┣ 📂assets
 ┣ 📂build                           # Flutter가 빌드한 결과물
 ┃ ┣ 📂web
 ┃ ┃ ┗ 📜index.html
 ┣ 📂lib
 ┃ ┣ 📂controller                    # 컴포넌트 폴더
 ┃ ┃ ┣ 📜calendar_controller.dart    # GetX 상태관리 컨트롤러 파일
 ┃ ┃ ┗ 📜moon_icon.dart              # 재사용 가능한 아이콘 위젯
 ┃ ┣ 📂screen                        # 화면 단위 위젯 (각 페이지별 UI 구성)
 ┃ ┃ ┣ 📜calendar.dart
 ┃ ┃ ┣ 📜list.dart
 ┃ ┃ ┗ 📜search.dart
 ┃ ┗ 📜main.dart                     # 앱 실행 진입점, 전체 라우팅 및 초기 설정
 ┗ 📜README.md
```

## 🛠️ 사용 기술

### 1. Frond-End

| 사용기술 | 설명 |Badge |
| :---:| :---: | :---: |
| **Flutter** | **크로스 플랫폼 앱 개발 프레임워크** |![flutter](https://img.shields.io/badge/flutter-02569B?style=flat-square&logo=flutter&logoColor=white)|
| **Dart** | **Flutter 전용 프로그래밍 언어** |![dart](https://img.shields.io/badge/dart-0175C2?style=flat-square&logo=dart&logoColor=white)|
| **GetX** | **상태 관리** |![getx](https://img.shields.io/badge/getx-8A2BE2?style=flat-square&logo=getx&logoColor=white)|
| **Hive** | **경량(key-value) 로컬 데이터베이스** |![dart](https://img.shields.io/badge/Hive-0175C2?style=flat-square&logo=dart&logoColor=white)|

### 2. 개발 도구

|사용기술 | 설명 | Badge | 
|:---:| :---: |:---: |
| **Visual Studio Code<br>(VS Code)** | **코드 편집기( 에디터 )** |![VSCode](https://img.shields.io/badge/VSCode-007ACC?style=flat-square&logo=data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzIiIGhlaWdodD0iMzIiIHZpZXdCb3g9IjAgMCAzMiAzMiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTI0LjAwMyAyTDEyIDEzLjMwM0w0Ljg0IDhMMiAxMEw4Ljc3MiAxNkwyIDIyTDQuODQgMjRMMTIgMTguNzAyTDI0LjAwMyAzMEwzMCAyNy4wODdWNC45MTNMMjQuMDAzIDJaTTI0IDkuNDM0VjIyLjU2NkwxNS4yODkgMTZMMjQgOS40MzRaIiBmaWxsPSJ3aGl0ZSIvPgo8L3N2Zz4K&logoColor=white) |
|**GitHub** | **버전 관리** |![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=GitHub&logoColor=white)| 
| **Vercel** | **서버리스 플랫폼** |![Vercel](https://img.shields.io/badge/Vercel-000000?style=flat-square&logo=vercel&logoColor=white)|
| **Figma** | **디자인 & UI/UX**|![Figma](https://img.shields.io/badge/Figma-F24E1E?style=flat-square&logo=Figma&logoColor=white) |

## 🧂전체 소스 코드

이 저장소에는 Flutter 웹 빌드 결과물만 포함되어 있습니다.<br>
프로젝트 전체 소스를 보시려면 아래 링크를 클릭해 주세요 !

- [Flutter 전체 소스](https://github.com/mocha-a/heunjeok)

## 📚 참고 URL

- 기획서 : heunjeok Google Docs
- 화면 설계 : heunjeok Figma
- ppt : heunjeok Canva

## 🌠 트러블슈팅 (Troubleshooting)

> 개발 중 이슈와 해결 방안
> 

 - 모바일에서 showModalBottomSheet 사용 시 키보드가 올라오면 입력 필드와 저장 버튼이 가려지고, 버튼 클릭이 불가능한 현상이 발생

    ⇒ **원인**: 모달 하단이 키보드에 의해 가려지면서 뷰포트가 자동으로 조정되지 않아 입력 필드와 버튼이 화면 밖에 위치하게 되었음

    ⇒ **해결방법**: 
    - isScrollControlled: true 옵션을 추가하여 모달이 키보드에 맞게 올라가도록 설정 
    - Padding 위젯에 MediaQuery.of(context).viewInsets.bottom을 적용해 키보드 높이만큼 여백 확보
    - Column의 mainAxisSize를 MainAxisSize.min으로 설정해 모달 크기를 내용에 맞게 조절하여 UI가 키보드에 가려지지 않도록 개선


## 💭 느낀점

Flutter와 친해지기 위해 만든 첫 번째 프로젝트였다.<br>
처음에는 정적 타입 언어에 익숙하지 않아서 Dart의 타입 시스템에 적응하는 데 어려움이 있었고, 특히 Hive에 데이터를 저장하고 불러올 때 타입 오류로 인해 에러가 자주 발생했다.<br><br>

하지만 Flutter의 구조가 React와 유사한 점이 많아 전체적인 흐름을 이해하는 데는 큰 어려움이 없었고, 자연스럽게 적응할 수 있었다.<br>
또한 Dart는 TypeScript와 일부 구조나 문법이 비슷한 부분이 있어, 이번 경험이 추후 타입스크립트를 공부할 때 간접적으로 도움이 될 수 있을 것 같다고 느꼈다.
