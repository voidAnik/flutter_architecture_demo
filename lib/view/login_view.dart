import 'package:flutter/material.dart';
import 'package:mvvm/res/components/Loading_button.dart';
import 'package:mvvm/utils/messenger.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/login_view_model.dart';

import '../model/User.dart';
import '../utils/utils.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  late final loginViewModel;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _obscurePassword.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    _emailController.text = "eve.holt@reqres.in";
    _passwordController.text = "cityslicka";
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    debugPrint("full build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: loginViewModel.test,
              labelText: "Email",
              prefixIcon: Icon(Icons.alternate_email)
            ),
            onFieldSubmitted: (value){
              Utils.fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
            },
          ),
          ValueListenableBuilder(
            valueListenable: _obscurePassword,
            builder: (context, value, child){
              return TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscurePassword.value,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_open),
                    suffixIcon: InkWell(
                      onTap: (){
                        _obscurePassword.value = !_obscurePassword.value;
                      },
                        child: Icon(
                          _obscurePassword.value ? Icons.visibility_off_outlined :
                            Icons.visibility_outlined)
                    )
                ),
              );
            }
          ),
          SizedBox(
            height: height*.1,
          ),
          Consumer<LoginViewModel>(
            builder: (context, viewModel, _){
              return LoadingButton(
                  title: "Login",
                  loading: viewModel.loading,
                  onPressed: (){
                    if(_emailController.text.toString().isEmpty){
                      Messenger.flushBarError("Please enter email", context);
                    } else if(_passwordController.text.toString().isEmpty){
                      Messenger.flushBarError("Please enter password", context);
                    } else if(_passwordController.text.toString().length < 6){
                      Messenger.flushBarError("Please 6 digit password", context);
                    } else {
                      User user = User(
                          _emailController.text.toString(),
                          _passwordController.text.toString()
                      );

                      viewModel.login(context, user);
                    }
                  });
            }),
        ],
      ),
    );
  }
}
