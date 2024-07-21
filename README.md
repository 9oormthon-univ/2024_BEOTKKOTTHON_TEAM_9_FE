# 2024_BEOTKKOTTHON_TEAM_9_FE


# 👋 introduce team member

| 이름                                        |대학교        |역할  | 이메일                |
| -------------------------------------------- | -------------- | ------ | -------------------- |
| [황현정](https://github.com/bunju20)       | 동국대학교 | 팀장, 프론트엔드 | ghkd4009@gmail.com |
| [여은동](https://github.com/sillonjeu) | 동국대학교     | 프론트엔드 | pius0316@gmail.com |
| [김나령](https://github.com/nar0ng) | 덕성여자대학교     | 백엔드 | criticalpxint@naver.com |
| [권보궁](https://github.com/kwon416) | 단국대학교    | 백엔드 | kbg990416@gmail.com |
| 정민지 | 동덕여자대학교     | 기획 | pop0080@naver.com |
| 이지혜 | 서울여자대학교    | 디자인 | fox8128@naver.com |


---

# 🛠️ Tech

## Frameworks
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## Backend
![Spring](https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-F2F4F9?style=for-the-badge&logo=spring-boot)
![Spring Security](https://img.shields.io/badge/Spring_Security-6DB33F?style=for-the-badge&logo=spring-security&logoColor=white)
![Spring Data JPA](https://img.shields.io/badge/Spring_Data_JPA-6DB33F?style=for-the-badge&logo=spring&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)

## Chat Bot
![OpenAI](https://img.shields.io/badge/OpenAI-412991?style=for-the-badge&logo=openai&logoColor=white)
![LangChain](https://img.shields.io/badge/LangChain-34D058?style=for-the-badge&logo=langchain&logoColor=white)

## Database
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Amazon RDS](https://img.shields.io/badge/Amazon_RDS-527FFF?style=for-the-badge&logo=amazon-rds&logoColor=white)

## Storage
![Amazon S3](https://img.shields.io/badge/Amazon_S3-569A31?style=for-the-badge&logo=amazon-s3&logoColor=white)

## Infrastructure
![Amazon EC2](https://img.shields.io/badge/Amazon_EC2-FF9900?style=for-the-badge&logo=amazonec2&logoColor=white)

---

## Flutter Project Build Instructions
```
flutter pub get
flutter run

## If you encounter any issues in iOS build, follow these steps to clean your build cache for iOS
cd ios
rm Podfile.lock
rm Podfile
rm -rf Pods
pod cache clean --all
cd ..
flutter clean
flutter pub get
cd ios
pod install
flutter pub get
flutter run

## If you encounter any issues in Android build, follow these steps to clean your build cache for Android 
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```
## Project Introduction

## Architecture

### 💻 demonstration video
 
https://github.com/goormthon-Univ/2024_BEOTKKOTTHON_TEAM_9_FE/assets/59414536/9116a501-c58c-4937-84aa-5f21ddeaf2f9

### ✨ Screen
| Title         | Img                                   | Title         | Img                                   |
| ------------ | ---------------------------------------- | ------------ | ---------------------------------------- |
| 메인 스크린    | <img width="344" alt="스크린샷 2024-03-24 오전 4 18 39" src="https://github.com/goormthon-Univ/2024_BEOTKKOTTHON_TEAM_9_FE/assets/59414536/f736e79b-a258-4c28-b141-5a343818f368">| 유기견 상세 스크린  | <img width="344" alt="스크린샷 2024-03-24 오전 4 19 24" src="https://github.com/goormthon-Univ/2024_BEOTKKOTTHON_TEAM_9_FE/assets/59414536/9e0824dd-427c-4afa-8bab-db0d7439de65">|
| 유기견과 채팅 스크린    |<img width="344" alt="image" src="https://github.com/goormthon-Univ/2024_BEOTKKOTTHON_TEAM_9_FE/assets/59414536/d3f0b851-9e4c-4e41-b380-1b6ffe180779">| 대화하기 스크린   | <img width="344" alt="스크린샷 2024-03-24 오전 4 21 17" src="https://github.com/goormthon-Univ/2024_BEOTKKOTTHON_TEAM_9_FE/assets/59414536/1086b69a-30ca-4a99-9cfc-07f024d09a66">|
| 좋아요 스크린 | <img width="344" alt="스크린샷 2024-03-24 오전 4 22 23" src="https://github.com/goormthon-Univ/2024_BEOTKKOTTHON_TEAM_9_FE/assets/59414536/67a72203-baa0-445d-8a80-0e04e34c7ba0">| 마이페이지 스크린   | <img width="344" alt="스크린샷 2024-03-24 오전 4 22 40" src="https://github.com/goormthon-Univ/2024_BEOTKKOTTHON_TEAM_9_FE/assets/59414536/b812d729-309a-4688-87ad-a86da2a16b50">|


---

## 🎯 Commit Convention

- feat: Add a new feature
- fix: Bug fix
- docs: Documentation updates
- style: Code formatting, missing semicolons, cases where no code change is involved
- refactor: Code refactoring
- test: Test code, adding refactoring tests
- hore: Build task updates, package manager updates

## 💡 PR Convetion

| 아이콘 | 코드                       | 설명                     |
| ------ | -------------------------- | ------------------------ |
| 🎨     | :art                       | Improving structure/format of the code   |
| ⚡️    | :zap                       | Performance improvement               |
| 🔥     | :fire                      | 	Code/file deletion          |
| 🐛     | :bug                       | Bug fix             |
| 🚑     | :ambulance                 | Critical fix|
| ✨     | :sparkles                  | New features               |
| 💄     | :lipstick                  | Adding/updating UI/style files |
| ⏪     | :rewind                    | Reverting changes     |
| 🔀     | :twisted_rightwards_arrows | Branch merging            |
| 💡     | :bulb                      | Adding/updating comments         |
| 🗃      | :card_file_box             | Database-related modifications   |

## Lisence

