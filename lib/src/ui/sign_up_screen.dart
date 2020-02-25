import 'package:cartech_app/src/blocs/sign_up_bloc.dart';
import 'package:cartech_app/src/models/sign_up_state.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cartech_app/src/ui/theme_resources.dart';


class SignUpScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();

  }

}

class SignUpScreenState extends State<SignUpScreen>{

  SignUpBloc signUpBloc = SignUpBloc();

  Widget _textField(String hintText, bool isPassword, TextEditingController controller) {
    return Container(
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Resources.MainColor)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Resources.MainColor),),
          border: OutlineInputBorder(borderSide: BorderSide(color: Resources.MainColor),),
          hintText: hintText,
        ),
      ),
    );
  }


  Widget _signUpButton(){
    return StreamBuilder<SignUpState>(
      stream: signUpBloc.signUpStateStream,
      builder: (context, snapshot) {

        if(snapshot.data is SignUpStateLoading){
          return Container(child: CircularProgressIndicator(), padding: EdgeInsets.all(5),);
        }


        return InkWell(
          onTap: () async {
              signUpBloc.signUp();
          },

          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width/3,
            child: Text("Crear cuenta", style: TextStyle(color: Colors.grey[100]),),
            decoration: BoxDecoration(
              color: Resources.MainColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text("Crear cuenta",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                SizedBox(height: 30,),
                _textField("Nombre", false, signUpBloc.nameController),
                SizedBox(height: 20,),
                _textField("Apellido", false, signUpBloc.lastNameController),
                SizedBox(height: 20,),
                _textField("Correo electronico", false, signUpBloc.emailController),
                SizedBox(height: 20,),
                _textField("Numero de telefono", false, signUpBloc.phoneNumberController),
                SizedBox(height: 20,),
                _textField("Contrasena", true, signUpBloc.passwordController),
                SizedBox(height: 20,),
                _signUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    signUpBloc.signUpStateStream.listen( (data){
      if(data is SignUpStateError){
        _showDialog(data.errorMessage);
      }
      else if(data is SignUpStateDone){
        Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          message: "Reservacion creada con exito",
          icon: Icon(
            Icons.check_circle,
            size: 28.0,
            color: Colors.blue,
          ),
          backgroundColor: Colors.purple,
          duration: Duration(seconds: 1),
          leftBarIndicatorColor: Colors.green,

        ).show(context).then( (r){
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      }
    });
  }
}