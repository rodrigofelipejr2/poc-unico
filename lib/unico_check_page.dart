import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unico_check/abstracts/IAcessoBio.dart';
import 'package:unico_check/abstracts/IAcessoBioCamera.dart';
import 'package:unico_check/result/success/ResultCamera.dart';
import 'package:unico_check/result/error/ErrorBio.dart';
import 'package:unico_check/unico_check.dart';

import 'acesso_pass.dart';

class UnicoCheckPage extends StatefulWidget {
  const UnicoCheckPage({Key key}) : super(key: key);

  @override
  _UnicoCheckPageState createState() => _UnicoCheckPageState();
}

class _UnicoCheckPageState extends State<UnicoCheckPage> implements IAcessoBio, IAcessoBioCamera {
  UnicoCheck unicoCheck;

  @override
  void initState() {
    super.initState();

    initAcessoBio();
  }

  void initAcessoBio() {
    unicoCheck = new UnicoCheck(
      this,
      AcessoPass.url,
      AcessoPass.apiKey,
      AcessoPass.token,
    );
    configLayout();
  }

  Future<void> configLayout() async {
    // --- CUSTOM LAYOUT Android
    unicoCheck.setAndroidColorBackground("#901850");
    unicoCheck.setAndroidColorBoxMessage("#901850");
    unicoCheck.setAndroidColorTextMessage("#901850");
    unicoCheck.setAndroidColorBackgroundPopupError("#901850");
    unicoCheck.setAndroidColorTextPopupError("#901850");
    unicoCheck.setAndroidColorBackgroundButtonPopupError("#901850");
    unicoCheck.setAndroidColorTextButtonPopupError("#901850");
    unicoCheck.setAndroidColorBackgroundTakePictureButton("#901850");
    unicoCheck.setAndroidColorIconTakePictureButton("#901850");
    unicoCheck.setAndroidColorBackgroundBottomDocument("#901850");
    unicoCheck.setAndroidColorTextBottomDocument("#901850");
    unicoCheck.setAndroidColorSilhoutte("#87CEFA", "#87CEFA");

    // --- CUSTOM LAYOUT IOS
    unicoCheck.setIosColorSilhoutteNeutra("#901850");
    unicoCheck.setIosColorSilhoutteSuccess("#901850");
    unicoCheck.setIosColorSilhoutteError("#901850");
    unicoCheck.setIosColorBackground("#901850");
    unicoCheck.setIosColorBackgroundBoxStatus("#901850");
    unicoCheck.setIosColorTextBoxStatus("#901850");
    unicoCheck.setIosColorBackgroundPopupError("#901850");
    unicoCheck.setIosColorTextPopupError("#901850");
    unicoCheck.setIosImageIconPopupError("#901850");
  }

  Future<void> initCamera() async {
    unicoCheck.openCamera;
  }

  String get getTime {
    var now = DateTime.now();
    return now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: initCamera,
                child: const Text('Camera normal'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.amber,
      fontSize: 14,
    );
  }

  @override
  void onErrorCamera(ErrorBio errorBio) {
    showToast('Erro ao abrir a camera: ${errorBio.description}');
    debugPrint('## onErrorAcessoBio $getTime');
  }

  @override
  void onErrorDocumentInsert(String error) {
    // showToast('Erro ao : ${error}');
    debugPrint('## onErrorDocumentInsert $getTime');
  }

  @override
  void onSuccessCamera(ResultCamera result) {
    showToast('Sucesso na captura, aqui temos o base64');
    debugPrint('## onSuccessCamera $getTime');
    debugPrint(result.base64);
  }

  @override
  void onSucessDocumentInsert(String processId, String typed) {
    // showToast('Sucesso na : ${error}');
    debugPrint('## onSucessDocumentInsert $getTime');
    debugPrint('## processId $processId');
    debugPrint('## typed $typed');
  }

  @override
  void onErrorAcessoBio(ErrorBio errorBio) {
    showToast('Erro ao abrir a camera: ${errorBio.description}');
    debugPrint('## onErrorAcessoBio $getTime');
  }

  @override
  void userClosedCameraManually() {
    showToast('Usuário fechou camera manualmente!');
    debugPrint('## userClosedCameraManually $getTime');
  }
}
