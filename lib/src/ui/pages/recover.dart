import 'package:fastshop/src/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final inputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(color: Colors.grey.shade400),
);

final inputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
  border: inputBorder,
  focusedBorder: inputBorder,
  enabledBorder: inputBorder,
);

class RecoverPage extends StatefulWidget {
  const RecoverPage({Key? key}) : super(key: key);

  @override
  State<RecoverPage> createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
  @override
  Widget build(BuildContext context) {
    return const First();
  }
}

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  void initState() {
    //Get.find<AuthController>().backButtonActive.value = false;
    //loginController.showMethod.value = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthController loginController = Get.find<AuthController>();

    // final size = MediaQuery.of(context).size;
    return Column(
      children: [
        welcomeText(loginController),
        Obx(() => !loginController.showMethod.value
            ? fieldVerify(loginController)
            : const SizedBox()),
        Obx(() => loginController.showMethod.value
            ? methodCardSms(loginController)
            : const SizedBox()),
        Obx(() => loginController.showMethod.value
            ? methodCardEmail(loginController)
            : const SizedBox())
      ],
    );
  }
}

Widget welcomeText(loginController) {
  return Column(
    children: [
      Container(
        height: 250,
        padding: const EdgeInsets.all(35),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          "assets/images/5215545.jpg",
          fit: BoxFit.contain,
        ),
      ),
      Obx(() => loginController.showMethod.value
          ? Text.rich(
              TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 18.0,
                  color: Colors.black,
                  height: 1.0,
                ),
                children: const [
                  TextSpan(
                    text: 'Selecciona un',
                  ),
                  TextSpan(
                    text: ', ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: 'Metodo',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: ' ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: 'para continuar!',
                  ),
                ],
              ),
            )
          : const SizedBox())
    ],
  );
}

Widget fieldVerify(loginController) {
  return Container(
    margin: const EdgeInsets.only(top: 25),
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Ingrese su Usuario o Contraseña",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Usuario',
                        labelText: 'Usuario',
                        constraints:
                            BoxConstraints(maxWidth: 140, maxHeight: 60)),
                    obscureText: false,
                    onChanged: (value) {
                      loginController.fieldVerify.value = value;
                    },
                    onSaved: (value) {
                      loginController.fieldVerify.value = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "La Usuario o Contraseña es requerida";
                      }
                      return null;
                    },
                  ),
                ),
                const Text(
                  "@",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Dominio',
                        labelText: 'Dominio',
                        constraints:
                            BoxConstraints(maxWidth: 140, maxHeight: 60)),
                    obscureText: false,
                    onChanged: (value) {
                      loginController.schema.value = value;
                    },
                    onSaved: (value) {
                      loginController.schema.value = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "La Usuario o Contraseña es requerida";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                padding: const EdgeInsets.all(10.0),
                minimumSize: const Size(150, 50),
              ),
              child: const Text(
                "Continuar",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              onPressed: () {
                loginController.userVerify();
              },
            )
          ],
        ),
      ),
    ),
  );
}

Widget methodCardSms(loginController) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: const EdgeInsets.all(15),
    elevation: 10,
    child: Column(
      children: [
        ListTile(
          onTap: () => {Get.to(const Second())},
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
          title: const Text('Via SMS'),
          subtitle: Obx(() => Text(loginController.phone.value)),
          leading: Image.asset(
            "assets/images/smartphone.png",
            fit: BoxFit.contain,
          ),
        ),
      ],
    ),
  );
}

Widget methodCardEmail(loginController) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: const EdgeInsets.all(15),
    elevation: 10,
    child: Column(
      children: [
        ListTile(
          onTap: () => loginController.sendEmail(),
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
          title: const Text('Via Correo'),
          subtitle: Obx(() => Text(loginController.email.value)),
          leading: Image.asset(
            "assets/images/letter.png",
            fit: BoxFit.contain,
          ),
        ),

        // Usamos una fila para ordenar los botones del card
      ],
    ),
  );
}

class Second extends StatelessWidget {
  const Second({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController loginController = Get.find<AuthController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30.0),
            const Text(
              "Por favor ingresa el codigo de 4 digitos",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            const OTPFields(),
            const SizedBox(height: 20.0),
            const Text(
              "Expira en 02:22",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
            const SizedBox(height: 10.0),
/*             TextButton(
              child: const Text(
                "Reenviar",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {},
            ), */
            const SizedBox(height: 30.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                padding: const EdgeInsets.all(16.0),
                minimumSize: const Size(150, 50),
              ),
              child: const Text(
                "Confirmar",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              onPressed: () {
                loginController.verifyCode();
              },
            )
          ],
        ),
      ),
    );
  }
}

class Third extends StatelessWidget {
  const Third({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController loginController = Get.find<AuthController>();
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 25),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Cambio de Contraseña",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Text(
                  "Ingresa tu nueva Contraseña",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Contraseña',
                      labelText: 'Contraseña',
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      loginController.recovePassword.value = value;
                    },
                    onSaved: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "La Contraseña es requerida";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Contraseña',
                      labelText: 'Repita Contraseña',
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      loginController.replyRecovePassword.value = value;
                    },
                    onSaved: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "La Contraseña es requerida";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: const EdgeInsets.all(10.0),
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    "Continuar",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () => loginController.changePassword(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Four extends StatefulWidget {
  const Four({Key? key}) : super(key: key);

  @override
  State<Four> createState() => _FourState();
}

class _FourState extends State<Four> {
  double screenWidth = 600;

  double screenHeight = 400;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 250,
            padding: const EdgeInsets.all(35),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              "assets/images/checked.png",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Operaciòn Exitosa!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 36,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          const Text(
            "Tu contraseña ha sido cambiada exitosamente",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
          const Text(
            "Vuelve al inicio de sessiòn e ingresa al sistema con tu nueva contraseña",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          SizedBox(height: screenHeight * 0.06),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              padding: const EdgeInsets.all(10.0),
              minimumSize: const Size(150, 50),
            ),
            child: const Text(
              "Login",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            onPressed: () {
              Get.offAllNamed('/login');
            },
          )
        ],
      )),
    );
  }
}

class OTPFields extends StatefulWidget {
  const OTPFields({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OTPFieldsState createState() => _OTPFieldsState();
}

class _OTPFieldsState extends State<OTPFields> {
  FocusNode? pin2FN;
  FocusNode? pin3FN;
  FocusNode? pin4FN;
  final pinStyle = const TextStyle(fontSize: 32, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    pin2FN = FocusNode();
    pin3FN = FocusNode();
    pin4FN = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FN?.dispose();
    pin3FN?.dispose();
    pin4FN?.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthController loginController = Get.find<AuthController>();

    return Form(
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 60,
                child: TextFormField(
                  autofocus: true,
                  style: pinStyle,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: inputDecoration,
                  onChanged: (value) {
                    loginController.c1.value = value;
                    nextField(value, pin2FN);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin2FN,
                  style: pinStyle,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: inputDecoration,
                  onChanged: (value) {
                    loginController.c2.value = value;
                    nextField(value, pin3FN);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin3FN,
                  style: pinStyle,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: inputDecoration,
                  onChanged: (value) {
                    loginController.c3.value = value;
                    nextField(value, pin4FN);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin4FN,
                  style: pinStyle,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: inputDecoration,
                  onChanged: (value) {
                    loginController.c4.value = value;
                    if (value.length == 1) {
                      pin4FN!.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
