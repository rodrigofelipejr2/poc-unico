import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unico_check/unico_check.dart';

class UnicoCheckPage extends StatefulWidget {
  const UnicoCheckPage({Key? key}) : super(key: key);

  @override
  _UnicoCheckPageState createState() => _UnicoCheckPageState();
}

class _UnicoCheckPageState extends State<UnicoCheckPage> implements IAcessoBioSelfie {
  late final UnicoCheck unicoCheck;
  late final UnicoConfig unicoConfig;

  @override
  void initState() {
    super.initState();

    initAcessoBio();
  }

  void initAcessoBio() {
    unicoConfig = UnicoConfig(
      setTimeoutSession: 40.0,
      setTimeoutToFaceInference: 16.0,
      androidColorSilhouetteSuccess: "#03fc73",
      androidColorSilhouetteError: "#fc0303",
      iosColorSilhouetteSuccess: "#03fc73",
      iosColorSilhouetteError: "#fc0303",
    );

    unicoCheck = UnicoCheck(context: this, config: unicoConfig);
  }

  void openCameraAuto() {
    unicoCheck.camera!.setAutoCapture(true);
    unicoCheck.camera!.setSmartFrame(true);
    unicoCheck.camera!.openCamera();
    debugPrint('## openSmartCamera $getTime');
  }

  void openCameraNormal() {
    unicoCheck.camera!.setAutoCapture(false);
    unicoCheck.camera!.setSmartFrame(false);
    unicoCheck.camera!.openCamera();
    debugPrint('## openManualCamera $getTime');
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
                onPressed: openCameraNormal,
                child: const Text('Camera normal'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: openCameraAuto,
                child: const Text('Camera inteligente'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onErrorAcessoBio(ErrorBioResponse error) {
    showToast('Erro ao abrir a camera: ${error.description}');
    debugPrint('## onErrorAcessoBio $getTime');
  }

  @override
  void onErrorSelfie(ErrorBioResponse error) {
    showToast('Erro ao abrir a camera: ${error.description}');
    debugPrint('## onErrorSelfie $getTime');
  }

  @override
  void onSuccessSelfie(CameraResponse response) {
    showToast('Sucesso na captura, aqui temos o base64');
    debugPrint('## onSuccessSelfie $getTime');
    debugPrint(response.base64);
  }

  @override
  void onSystemChangedTypeCameraTimeoutFaceInference() {
    showToast('Sistema trocou o tipo da camera!');
    debugPrint('## onSystemChangedTypeCameraTimeoutFaceInference $getTime');
  }

  @override
  void onSystemClosedCameraTimeoutSession() {
    showToast("Sistema fechou a camera!");
    debugPrint('## onSystemClosedCameraTimeoutSession $getTime');
  }

  @override
  void onUserClosedCameraManually() {
    showToast('Usuário fechou camera manualmente!');
    debugPrint('## onUserClosedCameraManually $getTime');
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
}
