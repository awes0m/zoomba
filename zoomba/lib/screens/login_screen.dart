import 'package:flutter/material.dart';
import 'package:zoomba/resources/auth_methods.dart';
import 'package:zoomba/utils/text_styles.dart';
import 'package:zoomba/utils/utils.dart';
import 'package:zoomba/widgets/custom_neu_button.dart';

import '../widgets/app_text_form_field_widget.dart';
import '../utils/colors.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool res = false;
  // bool _isLoading = false;
  bool _isSignUp = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthMethods _authMethods = AuthMethods();

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Top Space
                SizedBox(height: ScrnSizer.screenHeight() * 0.1),
                // Top Text
                Text(
                  _isSignUp
                      ? 'Signup to Join Meeting'
                      : 'Start or Join a Meeting',
                  style: AppTextStyle.mediumBold(),
                ),
                //Signup or Login Box
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: SizedBox(
                    height: ScrnSizer.screenHeight() * 0.5,
                    width: ScrnSizer.screenWidth() * 0.8,
                    child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        ToggleButtons(
                          borderRadius: BorderRadius.circular(20),
                          fillColor: Colors.black,
                          borderColor: Colors.black,
                          highlightColor: buttonColor,
                          disabledColor: backgroundColor,
                          renderBorder: false,
                          isSelected: [
                            !_isSignUp,
                            _isSignUp,
                          ],
                          onPressed: (int index) {
                            setState(() {
                              index == 0 ? _isSignUp = false : _isSignUp = true;
                            });
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Sign In',
                                  style: AppTextStyle.mediumBold()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Sign Up',
                                  style: AppTextStyle.mediumBold()),
                            ),
                          ],
                        ),
                        // Name field for Sign up
                        const SizedBox(height: 40),
                        //Name Field
                        _isSignUp
                            ? AppTextFormField(
                                title: 'Name',
                                hintText: 'Enter your name',
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter an email';
                                  }
                                  return null;
                                },
                              )
                            : Container(),
                        const SizedBox(height: 20),
                        //Email Field
                        AppTextFormField(
                          title: 'Email',
                          hintText: 'Enter your email',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              showSnackBar(context, 'Please enter your email');
                            }
                            if (isValidEmail(value)) {
                              showSnackBar(
                                  context, 'Please enter a valid email');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        //Password Field
                        AppTextFormField(
                          title: 'Password',
                          hintText: 'Enter your password',
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ]),
                    ),
                  ),
                ),
                // Signup or Login Button
                CustomNeuButton(
                    text: _isSignUp ? 'Sign Up' : 'Email Sign In',
                    buttonWidth: ScrnSizer.screenWidth() * 0.8,
                    backgroundColor: backgroundColor,
                    onPressed: () async {
                      if (_isSignUp) {
                        await _authMethods.signUpWithEmail(
                                context: context,
                                userEmail: emailController.text,
                                userPassword: passwordController.text,
                                name: nameController.text)
                            ? Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName)
                            : null;
                      } else {
                        await _authMethods.signInWithEmail(context,
                                emailController.text, passwordController.text)
                            ? Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName)
                            : null;
                      }
                    }),
                const SizedBox(height: 20),
                // Google Sign In Button
                _isSignUp
                    ? const SizedBox()
                    : CustomNeuButton(
                        text: 'Google Sign In',
                        buttonWidth: ScrnSizer.screenWidth() * 0.8,
                        backgroundColor: Colors.deepOrange[900]!,
                        onPressed: () async {
                          await _authMethods.signInWithGoogle(context)
                              ? Navigator.pushNamed(
                                  context, HomeScreen.routeName)
                              : null;
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
