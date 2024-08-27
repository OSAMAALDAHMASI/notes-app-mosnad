import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import 'home.dart';

  class BiometricAuthPage extends StatefulWidget {
  @override
  _BiometricAuthPageState createState() => _BiometricAuthPageState();
}

class _BiometricAuthPageState extends State<BiometricAuthPage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBiometrics = false;
  List<BiometricType> _availableBiometrics = [];
  bool _isAuthenticating = false;
  String _authMessage = 'Tap the button below to authenticate';

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      canCheckBiometrics = false;
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });

    if (_canCheckBiometrics) {
      List<BiometricType> availableBiometrics;
      try {
        availableBiometrics = await _localAuthentication.getAvailableBiometrics();
      } catch (e) {
        availableBiometrics = <BiometricType>[];
      }

      setState(() {
        _availableBiometrics = availableBiometrics;
      });
    }
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authMessage = 'Authenticating...';
        Get.off(const NotesPage());
      });

      authenticated = await _localAuthentication.authenticate(
        localizedReason: 'Authenticate to access the app',
        // useErrorDialogs: true,
        // stickyAuth: true,
      );

      setState(() {
        _isAuthenticating = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authMessage = 'Authentication failed';
      });
      return;
    }

    if (!mounted) return;

    setState(() {
      if (authenticated) {
        _authMessage = 'Authentication successful';
      } else {
        _authMessage = 'Authentication failed';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_authMessage),
              const SizedBox(height: 16.0),
              if (_canCheckBiometrics)
                ElevatedButton(
                  onPressed: _isAuthenticating ? null : _authenticate,
                  child: _isAuthenticating
                      ? const CircularProgressIndicator()
                      : const Text('Authenticate'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}