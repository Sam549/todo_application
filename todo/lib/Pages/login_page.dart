import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Login/Logout'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                child: Image.network(
                    'http://blog.back4app.com/wp-content/uploads/2017/11/logo-b4a-1-768x175-1.png'),
              ),
              Center(
                child: const Text('Flutter on Back4App',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: const Text('User Login/Logout',
                    style: TextStyle(fontSize: 16)),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: controllerUsername,
                enabled: !isLoggedIn,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Username'),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: controllerPassword,
                enabled: !isLoggedIn,
                obscureText: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Password'),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 50,
                child: TextButton(
                  child: const Text('Login'),
                  onPressed: isLoggedIn ? null : () => doUserLogin(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 50,
                child: TextButton(
                  child: const Text('Logout'),
                  onPressed: !isLoggedIn ? null : () => doUserLogout(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 50,
                child: TextButton(
                  child: const Text('Signup'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

 void doUserLogin() async {
  final username = controllerUsername.text.trim();
  final password = controllerPassword.text.trim();

  final user = ParseUser(username, password, null);

  try {
    var response = await user.login();

    if (response.success) {
      showSuccess("User was successfully login!");
      setState(() {
        isLoggedIn = true;
      });
      Navigator.pushNamed(context, '/home');
    } else {
      showError(response.error!.message);
    }
  } catch (e) {
    showError("An error occurred while logging in: $e");
  }
}
}

doUserLogout() {
}