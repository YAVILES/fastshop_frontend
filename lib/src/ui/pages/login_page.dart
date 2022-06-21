import 'package:fastshop/src/controllers/auth_controller.dart';
import 'package:fastshop/src/ui/widgets/buttons/custom_button_primary.dart';
import 'package:fastshop/src/ui/widgets/progress_indicators/custom_progress_indicator.dart';
import 'package:fastshop/src/ui/widgets/textformfields/textform_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 25),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Image.asset(
            "assets/images/logo.webp",
            height: 200,
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -40),
          child: const Center(
            child: CardLogin(),
          ),
        )
      ],
    );
  }
}

class CardLogin extends StatefulWidget {
  const CardLogin({Key? key}) : super(key: key);

  @override
  CardLoginState createState() => CardLoginState();
}

class CardLoginState extends State<CardLogin> {
  @override
  Widget build(BuildContext context) {
    final AuthController loginController = Get.find<AuthController>();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: SizedBox(
            width: constraints.maxWidth > 600 ? 500 : double.infinity,
            child: Form(
              key: loginController.formLoginKey,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 240,
                  bottom: 20,
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 30,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Iniciar Sesión",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Inicie sesión en su cuenta para continuar",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomTextFormField(
                        initialValue: loginController.username.value,
                        onChanged: (value) {
                          loginController.username.value = value;
                        },
                        onSaved: (value) {
                          loginController.username.value = value ?? "";
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "EL usuario es requerido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      CustomTextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          loginController.password.value = value;
                        },
                        onSaved: (value) {
                          loginController.password.value = value ?? "";
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "La contraseña es requerido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      Obx(() {
                        return loginController.loading.isFalse
                            ? CustomButtonPrimary(
                                text: "Iniciar",
                                function: () => loginController.doLogin(),
                              )
                            : const CustomProgressIndicator();
                      }),
                      const SizedBox(height: 15),
                      TextButton(
                        child: const Text("¿Se te olvidó la contraseña?"),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
