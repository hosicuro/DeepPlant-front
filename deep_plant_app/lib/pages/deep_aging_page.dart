import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class DeepAging extends StatefulWidget {
  const DeepAging({super.key});

  @override
  State<DeepAging> createState() => _DeepAgingState();
}

class _DeepAgingState extends State<DeepAging> {
  // 딥에이징 데이터 추가 시에 등록될 버튼이 추가될 위치.
  List<Widget> widgets = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: '', backButton: false, closeButton: true),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '딥에이징 데이터',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(
                  right: 30.0,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 0.5,
                      ),
                      elevation: 0,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      )),
                  child: Text(
                    // 이는 엑셀 파일을 업로드 하기 위한 버튼이다.
                    '엑셀파일 업로드',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widgets,
          ),
          // 만일 버튼 위젯이 4개가 된다면, 추가 버튼은 사라질 것이다.
          if (widgets.length < 4)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 5.0,
                    bottom: 5.0,
                    left: 30.0,
                    right: 30.0,
                  ),
                  height: 70.0,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(
                        () {
                          // 이로 인해 버튼이 추가되어 표현된다.
                          widgets.add(
                            Container(
                              padding: EdgeInsets.only(
                                top: 5.0,
                                bottom: 5.0,
                                left: 30.0,
                                right: 30.0,
                              ),
                              height: 70.0,
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        maxLines: 2,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '  ${widgets.length + 1}차\n',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '처리일',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: VerticalDivider(
                                        thickness: 2,
                                        width: 1,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '6시간 00분',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '2022.09.19',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.black,
                                        size: 20.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    // 이 아래는 추가하는 버튼에 대한 내용이며, 위는 setState를 통해 버튼이 만들어진다.
                    icon: Icon(
                      Icons.add,
                      size: 30.0,
                      color: Colors.grey[400],
                    ),
                    label: Text(
                      '추가하기',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Text(
                  '총처리횟수/총처리시간',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.grey[300],
                  ),
                  child: Center(
                    child: Text(
                      '${widgets.length}회/ ${widgets.length * 6}시간 00분',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
