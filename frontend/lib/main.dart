import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/page/auth/loginpage.dart';
import 'package:frontend/page/response/mobileScreenLayout.dart';
import 'package:frontend/page/response/responsiveLayoutScreen.dart';
import 'package:frontend/page/response/webScreenLayout.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart ' as http;

final GoogleSignInAccount? user = _currentUser;
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

final GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId:
      '317921682520-osl28bu3k92j0st1hjm9ehvc8m9n29jl.apps.googleusercontent.com',
  scopes: scopes,
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

GoogleSignInAccount? _currentUser;
bool _isAuthorized = false; // has granted permissions?
String _contactText = '';

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
        (dynamic name) =>
            (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  // 로그인한 사용자가 정보를 검색할 수 있도록 People API REST 엔드포인트를 호출합니다.
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      // 모바일에서 인증을 받는다는 것은 인증을 받는다는 뜻...
      bool isAuthorized = account != null;
// 그러나 웹에서는...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });
// 이제 사용자가 필요한 범위에 액세스할 수 있음을 알았으므로 앱
      // REST API를 호출할 수 있습니다.
      if (isAuthorized) {
        _handleGetContact(account!);
      }
    });

    // 웹에서 _googleSignIn.signInSilently()는 One Tap UX를 트리거합니다.
    //
    // Google Identity Services에서 One Tap UX를 모두 렌더링하도록 권장합니다.
    // 및 Google 로그인 버튼을 함께 사용하여 "마찰을 줄이고 개선
    // 로그인 속도'([문서](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  // 사용자에게 `범위`를 승인하라는 메시지를 표시합니다.
  //
  // 이 작업은 인증을 수행하지 않는 플랫폼에서 **필수**입니다.
  // 그리고 인증을 동시에(웹처럼).
  //
  // 웹에서는 사용자 상호작용(버튼 클릭)에서 호출해야 합니다.
  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await _googleSignIn.requestScopes(scopes);
    setState(() {
      _isAuthorized = isAuthorized;
    });
    if (isAuthorized) {
      _handleGetContact(_currentUser!);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user == null) {
      print('로그인실패');
      // The user is NOT Authenticated
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('You are not currently signed in.'),
            // 이 방법은 조건부 내보내기로 모바일과 웹 코드를 분리하는 데 사용됩니다.
            // 참조: src/sign_in_button.dart
            ElevatedButton(
              onPressed: _handleSignIn,
              child: const Text('login'),
            ),
          ],
        ),
      );
      // The user is Authenticated
    } else {
      return const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            scaffoldBackgroundColor: const Color.fromRGBO(43, 41, 48, 1),
            drawerTheme: const DrawerThemeData(
                backgroundColor: Color.fromRGBO(29, 27, 32, 1)),
            textTheme: const TextTheme(
                bodyMedium:
                    TextStyle(color: Color.fromRGBO(202, 196, 208, 1)))),
        home: Wrapper());
  }
}

class Wrapper extends StatefulWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout());
  }
}
