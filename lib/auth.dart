import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  LocalAuthentication localAuthentication = LocalAuthentication();

  bool canAuth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () async {
              canAuth = await localAuthentication.canCheckBiometrics;

              print(canAuth.toString());
            },
            child: Center(child: Text('Check')),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: RaisedButton(
              onPressed: () async {
                List<BiometricType> list = List();
                try {
                  if (canAuth) {
                    list = await localAuthentication.getAvailableBiometrics();

                    if (list.length > 0) {
                      bool result =
                          await localAuthentication.authenticateWithBiometrics(
                              localizedReason:
                                  'Please enter your fingerprint to unlock',
                              useErrorDialogs: true,
                              stickyAuth: false);

                      print('resultis $result');

                      if (list.contains(BiometricType.fingerprint)) {
                        print('fingerprint');
                      }

                      if (list.contains(BiometricType.iris)) {
                        print('iris');
                      }

                      if (list.contains(BiometricType.face)) {
                        print('face unlock');
                      }
                    }
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Center(child: Text('Verify')),
            ),
          ),
        ],
      ),
    );
  }
}
