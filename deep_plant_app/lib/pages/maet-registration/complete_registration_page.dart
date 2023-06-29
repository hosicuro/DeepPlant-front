import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CompleteResgistration extends StatefulWidget {
  final MeatData meatData;
  const CompleteResgistration({
    super.key,
    required this.meatData,
  });

  @override
  State<CompleteResgistration> createState() => _CompleteResgistrationState();
}

class _CompleteResgistrationState extends State<CompleteResgistration> {
  String managementNumber = '';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    managementNumber =
        '${widget.meatData.historyNumber!}-${widget.meatData.species!}-${widget.meatData.lDivision!}-${widget.meatData.sDivision!}';
    sendDataToFirebase();
  }

  Future<void> sendDataToFirebase() async {
    setState(() {
      isLoading = true;
    });
    try {
      // meat 컬렉션에 데이터 저장
      final refData = firestore.collection('meat').doc(managementNumber);

      await refData.set({
        'trace_number': widget.meatData.historyNumber,
        'species': widget.meatData.species,
        'l_division': widget.meatData.lDivision,
        's_division': widget.meatData.sDivision,
        'fresh': widget.meatData.freshData,
      });

      // 0-0-0-0-0 에 관리번호 저장
      DocumentReference documentRef =
          firestore.collection('meat').doc('0-0-0-0-0');
      DocumentSnapshot documentSnapshot = await documentRef.get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          Map<String, dynamic>? fixField =
              data['fix_data'] as Map<String, dynamic>?;

          if (fixField != null) {
            List<dynamic>? meatArray = fixField['meat'] as List<dynamic>?;

            if (meatArray != null) {
              meatArray.add(managementNumber);
              await documentRef.update({'fix_data.meat': meatArray});
            }
          }
        }
      }

      // fire storage에 이미지 저장
      final refImage =
          FirebaseStorage.instance.ref().child('$managementNumber.png');

      await refImage.putFile(
        File(widget.meatData.imageFile!),
        SettableMetadata(contentType: 'image/jpeg'),
      );
    } catch (e) {
      print('error');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: isLoading
            ? Text('관리번호 생성중')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Text(
                    '관리번호',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    managementNumber,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '모든 등록이 완료되었습니다.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '데이터를 서버로 전송했습니다.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Icon(
                    Icons.check_circle_outline,
                    size: 50,
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: SaveButton(
                      onPressed: () => context.go('/option'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
