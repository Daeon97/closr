import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import '../cubits/cubits.dart';
import '../utils/utils.dart' as utils;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late OneShotAnimation _oneShotAnimation;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late ValueNotifier<bool> _obscureText;

  @override
  void initState() {
    _oneShotAnimation = OneShotAnimation(
      utils.manatimeLoginCharacterAnimationName,
      autoplay: false,
    );
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _obscureText = ValueNotifier<bool>(true);

    super.initState();
  }

  @override
  void dispose() {
    _oneShotAnimation.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _obscureText.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
        listener: (_, authState) {
          if (authState is AuthenticatedState) {
            Navigator.of(context).pushReplacementNamed(
              authState.route,
            );
          } else if (authState is UnAuthenticatedState &&
              authState.errorMessage != null) {
            utils.showError(
              context,
              message: authState.errorMessage!,
            );
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: utils.padding,
                right: utils.padding,
                bottom: utils.largePadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: utils.largePadding,
                  ),
                  SizedBox(
                    height: utils.threeHundredDotNil,
                    width: utils.eightHundredDotNil,
                    child: RiveAnimation.asset(
                      utils.manatimeLoginCharacterRiveAsset,
                      controllers: [
                        _oneShotAnimation,
                      ],
                    ),
                  ),
                  Text(
                    utils.signUpText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Form(
                    key: _formKey,
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (authCtx, authState) => AbsorbPointer(
                        absorbing: authState is AuthenticatingState,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: utils.padding,
                            ),
                            FocusScope(
                              child: Focus(
                                onFocusChange: (focused) {
                                  if (focused) {
                                    _oneShotAnimation.isActive = true;
                                  } else {
                                    _oneShotAnimation.isActive = false;
                                  }
                                },
                                child: TextFormField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.name,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(FontAwesomeIcons.font),
                                    labelText: utils.nameText,
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? utils.emptyNameFieldText
                                          : null,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: utils.padding,
                            ),
                            FocusScope(
                              child: Focus(
                                onFocusChange: (focused) {
                                  if (focused) {
                                    _oneShotAnimation.isActive = true;
                                  } else {
                                    _oneShotAnimation.isActive = false;
                                  }
                                },
                                child: TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(FontAwesomeIcons.at),
                                    labelText: utils.emailText,
                                  ),
                                  validator: (value) => value == null ||
                                          value.isEmpty
                                      ? utils.emptyEmailFieldText
                                      : !value.contains(utils.atSignText) ||
                                              !value.contains(utils.dotComText)
                                          ? utils.badEmailFormatText
                                          : null,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: utils.padding,
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: _obscureText,
                              builder: (_, obscureTextValue, __) => FocusScope(
                                child: Focus(
                                  onFocusChange: (focused) {
                                    if (focused) {
                                      _oneShotAnimation.isActive = true;
                                    } else {
                                      _oneShotAnimation.isActive = false;
                                    }
                                  },
                                  child: TextFormField(
                                    controller: _passwordController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      prefixIcon:
                                          const Icon(FontAwesomeIcons.lock),
                                      suffixIcon: IconButton(
                                        icon: obscureTextValue
                                            ? const Icon(FontAwesomeIcons.eye)
                                            : const Icon(
                                                FontAwesomeIcons.eyeSlash),
                                        onPressed: () {
                                          _obscureText.value =
                                              !obscureTextValue;
                                        },
                                      ),
                                      labelText: utils.passwordText,
                                    ),
                                    obscureText: obscureTextValue,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? utils.emptyPasswordFieldText
                                            : value.length <
                                                    utils.tinyPadding +
                                                        utils.tinyPadding +
                                                        utils.tinyPadding
                                                ? utils.passwordIsTooShortText
                                                : null,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: utils.largePadding,
                            ),
                            ElevatedButton(
                              style: authState is AuthenticatingState
                                  ? ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.grey,
                                      ),
                                    )
                                  : null,
                              onPressed: authState is AuthenticatingState
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();

                                      if (_formKey.currentState!.validate()) {
                                        authCtx.read<AuthCubit>().signUp(
                                              name: _nameController.text,
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                            );
                                      }
                                    },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    utils.padding,
                                  ),
                                  child: authState is AuthenticatingState
                                      ? SizedBox(
                                          width: utils.padding,
                                          height: utils.padding,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Theme.of(context)
                                                  .primaryColorLight,
                                            ),
                                            strokeWidth: utils.tinyPadding,
                                          ),
                                        )
                                      : Text(
                                          utils.signUpText,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: utils.largePadding,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: utils.alreadHaveAnAccountQuestionText,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: utils.whiteSpaceText,
                                  ),
                                  TextSpan(
                                    text: utils.signInText,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                          utils.signInScreenRoute,
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
