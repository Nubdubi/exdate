import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class GoogleSignInApi {
  static const _clientIDWeb =
      '317921682520-osl28bu3k92j0st1hjm9ehvc8m9n29jl.apps.googleusercontent.com';
  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);
  static final _googleSignInWeb = GoogleSignIn(clientId: _clientIDWeb);

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> weblogin() =>
      _googleSignInWeb.signInSilently();

  static Future logout() => _googleSignIn.disconnect();
}

// class AuthService {
//   Future<void> signIn() async {
//     // 고유한 redirect uri
//     const APP_REDIRECT_URI = "com.example.dexdate";

//     // 백엔드에서 미리 작성된 API 호출
//     final url = Uri.parse('/login/naver?redirect-uri=$APP_REDIRECT_URI');

//     // 백엔드가 제공한 로그인 페이지에서 로그인 후 callback 데이터 반환
//     final result = await FlutterWebAuth2.authenticate(
//         url: url.toString(), callbackUrlScheme: APP_REDIRECT_URI);

//     // 백엔드에서 redirect한 callback 데이터 파싱
//     final accessToken = Uri.parse(result).queryParameters['access-token'];
//     final refreshToken = Uri.parse(result).queryParameters['refresh-token'];
//     print(accessToken);
//     print(refreshToken);
//     // . . .
//     // FlutterSecureStorage 또는 SharedPreferences 를 통한
//     // Token 저장 및 관리
//     // . . .
//   }
// }

class LoginController extends GetxController {
  var _googleSignin = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  login() async {
    googleAccount.value = await _googleSignin.signIn();
  }
}
