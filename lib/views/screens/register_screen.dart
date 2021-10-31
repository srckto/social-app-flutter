import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/register_controller.dart';
import 'package:social_app/views/screens/login_screen.dart';
import 'package:social_app/views/widgets/defult_button.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  final RegisterController _controller = Get.put(RegisterController());

  TextEditingController _emailController = TextEditingController();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "REGISTER",
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(Icons.email_outlined),
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Email Address"),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please enter your email";
                        } else
                          return null;
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(Icons.person),
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Name"),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please enter your name";
                        } else
                          return null;
                      },
                    ),

                    SizedBox(height: 30),
                    Obx(
                      () => TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.lock_outline),
                          label: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text("password"),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              onPressed: () => _controller.changeVisibility(),
                              icon: _controller.visibility.value
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                            ),
                          ),
                        ),
                        obscureText: _controller.visibility.value,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter your password";
                          } else if (value.length < 6) {
                            return "Pawword is too short";
                          } else
                            return null;
                        },
                      ),
                    ),

                    SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(Icons.phone),
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Phone Number"),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please enter your phoneNumber";
                        } else
                          return null;
                      },
                    ),
                    SizedBox(height: 30),
                    // SizedBox()
                    Obx(() {
                      if (_controller.state.value == false) {
                        return DefultButton(
                          label: "Register",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _controller.register(
                                email: _emailController.text,
                                password: _passwordController.text,
                                name: _nameController.text,
                                phone: _phoneController.text,
                              );
                            }
                          },
                        );
                      } else
                        return CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        );
                    }),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You have an account ?",
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                                fontSize: 17,
                              ),
                        ),
                        DefultButton(
                          label: "LOGIN",
                          labelColor: Theme.of(context).primaryColor,
                          horizontalPadding: 10,
                          onPressed: () {
                            Get.off(() => LoginScreen());
                          },
                          elevation: 0.0,
                          primaryColor: Colors.transparent,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
