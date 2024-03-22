import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/AuthController.dart';
import '../../services/user_service.dart';
import '../../viewModels/home/post_viewmodel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/config/.env");
  Get.lazyPut(()=>AuthController());
  runApp(PostScreen());
}

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        // 앱 전체의 기본 배경색 설정
        scaffoldBackgroundColor: Color(0xFFF7F7F7),
        // AppBar의 기본 스타일 설정
        appBarTheme: AppBarTheme(
          color: Color(0xFFF7F7F7), // AppBar 배경색 설정
        ),
      ),
      home: _PostScreen(),
    );
  }
}
class _PostScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_PostScreen> {
  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.put(PostController());
    return Scaffold(
      appBar: AppBar(
        title: Text('유기견 공고 등록', style: FontSystem.KR20B),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
        child: SingleChildScrollView( // 스크롤 가능하게 만드는 위젯
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageSelectionWidget(),
              SizedBox(height: 30),
              Text('공고 번호', style: FontSystem.KR20B),
              SizedBox(height: 10),
              CustomTextField(C: controller.PostIdController),
              SizedBox(height: 30),
              Text('이름', style: FontSystem.KR20B),
              SizedBox(height: 10),
              CustomTextField(C: controller.nameController),
              SizedBox(height: 30),
              Text('나이', style: FontSystem.KR20B),
              SizedBox(height: 10),
              CustomTextField(C: controller.ageController),
              SizedBox(height: 20),
              Row(
                children: [
                  GenderButton(
                    title: '남',
                    isSelected: controller.genderController.text == '남',
                    onSelected: () {
                      setState(() {
                        controller.genderController.text = '남';
                      });
                    },
                  ),
                  SizedBox(width: 20), // 버튼 사이 간격
                  GenderButton(
                    title: '여',
                    isSelected: controller.genderController.text == '여', // 선택 상태에 따라 isSelected 값을 결정
                    onSelected: () {
                      setState(() {
                        controller.genderController.text = '여';
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text('종', style: FontSystem.KR20B),
              SizedBox(height: 10),
              CustomTextField(C:controller.breedController),
              SizedBox(height: 30),
              Text('성격', style: FontSystem.KR20B),
              SizedBox(height: 10),
              SelectableButtons(onSelected: (int ) {  },),
              SizedBox(height: 30),
              Text('좋아하는 것', style: FontSystem.KR20B),
              SizedBox(height: 10),
              CustomTextField(C:controller.likeController),
              SizedBox(height: 30),
              Text('싫어하는 것', style: FontSystem.KR20B),
              SizedBox(height: 10),
              CustomTextField(C:controller.hateController),
              SizedBox(height: 30),
              Text('강아지를 찾은 위치', style: FontSystem.KR20B),
              SizedBox(height: 10),
              CustomTextField(C:controller.findinglocationController),
              SizedBox(height: 30),
              Text('전하고 싶은 한 마디', style: FontSystem.KR20B),
              SizedBox(height: 10),
              CustomTextField(C:controller.extraController),
              SizedBox(height: 30),
              _BottomButton(),
            ],
          ),
        ),
      ),
    );
  }
}

// 입력 폼 생성
class CustomTextField extends StatelessWidget {
  final String placeholder;
  final double height;
  final TextEditingController C;

  const CustomTextField({
    Key? key,
    this.placeholder = '',
    this.height = 40, // 기본 높이
    required this.C,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final PostController controller = Get.put(PostController());
    return Container(
      child: TextField(
        controller: C, // 여기에서 onChanged 콜백을 사용합니다.
        maxLines: null,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: placeholder, // placeholder 변수 사용
          fillColor: Colors.white70,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          hintStyle: TextStyle(fontSize: 16.0, color: Color(0xFF878787)),
        ),
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}

// 성별 체크 버튼
class GenderButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onSelected;

  GenderButton({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: ElevatedButton(
        onPressed: onSelected, // 부모 위젯에서 제공한 콜백을 사용합니다.
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, backgroundColor: isSelected ? Color(0xFFA273FF) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(title, style: FontSystem.KR15R),
      ),
    );
  }
}

// 성격 체크 버튼
class SelectableButtons extends StatefulWidget {
  final Function(int) onSelected;

  SelectableButtons({Key? key, required this.onSelected}) : super(key: key);

  @override
  _SelectableButtonsState createState() => _SelectableButtonsState();
}
class _SelectableButtonsState extends State<SelectableButtons> {
  int _selectedIndex = -1; // 선택된 버튼의 인덱스

  Widget _buildButtonContent(int index) {
    if (index == 0) { // 특정 버튼에 대해서만 다른 스타일 적용
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "자신감이 넘쳐요\n",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
            ),
            TextSpan(
              text: "\"내가 바로 우두머리\"",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      );
    } else if(index == 1){
      // 기본 텍스트 스타일
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "부끄러움이 많고 소심해요\n",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
            ),
            TextSpan(
              text: "\"아.. 난 싫은데\"",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      );
    } else if(index == 2){
      // 기본 텍스트 스타일
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "활발하고 긍정적이에요\n",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
            ),
            TextSpan(
              text: "\"난 다 좋아요!\"",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      );
    } else if(index == 3){
      // 기본 텍스트 스타일
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "독립적이에요\n",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
            ),
            TextSpan(
              text: "\"난 혼자 할 수 있어!\"",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      );
    } else {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "사람을 좋아해요\n",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
            ),
            TextSpan(
              text: "\"우리 주인이 행복하다면\"",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.put(PostController());
    return Column(
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0), // 버튼 사이의 간격
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = index;
                  postController.announcement.character = "${_selectedIndex}";
                  postController.matchCharacter("${index}");
                });
                widget.onSelected(index);
              },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black, backgroundColor: _selectedIndex == index ? Color(0xFFA273FF) : Colors.white,
              minimumSize: Size(double.infinity, 75), // 버튼 높이 설정
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 곡률을 10으로 설정
              ),
            ),
            child: _buildButtonContent(index), // 위에서 정의한 메서드 사용
          ),
        );
      }),
    );
  }
}

// 바텀 버튼
class _BottomButton extends StatelessWidget {
  const _BottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    PostController controller = Get.put(PostController());
    return InkWell(
      onTap: () async {
        // Call the submitAnnouncement method and await its result
        bool success = await controller.attemptpost();
        if (success) {
          // Handle success, e.g., showing a Snackbar
        } else {
          // Handle failure, e.g., showing a Snackbar
        }
      },
      child: Container(
        width: Get.width * 0.8,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // 패딩 조정으로 버튼 크기 조정
        decoration: BoxDecoration(
          color: Color(0xFF040404), // 배경색 설정
          borderRadius: BorderRadius.circular(10), // 모서리 둥글기 반경 설정
        ),
        child: Text(
          '공고 등록하기', // 버튼 텍스트
          style: FontSystem.KR16B.copyWith(color: Colors.white), // 텍스트 스타일
          textAlign: TextAlign.center, // 텍스트 정렬
        ),
      ),
    );
  }
}

// 사진 고르기
class ImageSelectionWidget extends StatefulWidget {
  @override
  _ImageSelectionWidgetState createState() => _ImageSelectionWidgetState();
}

class _ImageSelectionWidgetState extends State<ImageSelectionWidget> {
  final PostController postController = Get.find<PostController>();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);
      // PostController에 이미지 파일 업데이트
      postController.updateDogPicture(selectedImage);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: postController.announcement.dogPicture != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            postController.announcement.dogPicture!,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        )
            : Center(
          child: Text('터치하여 사진을 올려주세요!', style: TextStyle(fontSize: 14)),
        ),
      ),
    );
  }
}