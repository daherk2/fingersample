import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';


void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Teste Leitor Digital"),),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.fingerprint),
                  iconSize: 100.0,
                  onPressed: () async {
                      try {
                        var localAuth = LocalAuthentication();
                        bool didAuthenticate = await localAuth
                            .authenticateWithBiometrics(
                            localizedReason: "Por favor entre com sua biometria",
                            useErrorDialogs: true,
                            stickyAuth: true
                        );
                        if(didAuthenticate){
                          Dialogo(context, "Mensagem", "Logado");
                        }else{
                          Dialogo(context, "Mensagem", "Erro no login");
                        }
                      } catch(e){
                        print(e);
                      }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Dialogo(context, title, message) {

  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () => Navigator.pop(context),
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}