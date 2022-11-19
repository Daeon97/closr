import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import '../cubits/cubits.dart';
import '../utils/utils.dart' as utils;

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late StateMachineController _stateMachineController;
  late SMIInput<bool> _isCheckingSMIInput;
  late SMIInput<double> _numLookSMIInput;
  late SMIInput<bool> _isHandsUpSMIInput;
  late SMIInput<bool> _trigSuccessSMIInput;
  late SMIInput<bool> _trigFailSMIInput;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late ValueNotifier<bool> _obscureText;

  void _onInit(
    Artboard artboard,
  ) {
    final stateMachineController = StateMachineController.fromArtboard(
      artboard,
      utils.animatedLoginCharacterStateMachineName,
    )!;

    artboard.addController(
      stateMachineController,
    );

    _isCheckingSMIInput = stateMachineController.findInput<bool>(
      utils.animatedLoginCharacterIsCheckingSMIInput,
    )!;

    _numLookSMIInput = stateMachineController.findInput<double>(
      utils.animatedLoginCharacterNumLookSMIInput,
    )!;

    _isHandsUpSMIInput = stateMachineController.findInput<bool>(
      utils.animatedLoginCharacterIsHandsUpSMIInput,
    )!;

    _trigSuccessSMIInput = stateMachineController.findInput<bool>(
      utils.animatedLoginCharacterTrigSuccessSMIInput,
    ) as SMIInput<bool>;

    _trigFailSMIInput = stateMachineController.findInput<bool>(
      utils.animatedLoginCharacterTrigFailSMIInput,
    ) as SMIInput<bool>;

    _stateMachineController = stateMachineController;
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _obscureText = ValueNotifier<bool>(true);

    super.initState();
  }

  @override
  void dispose() {
    _stateMachineController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _obscureText.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
        listener: (_, authState) {
          if (authState is AuthenticatedState) {
            _trigSuccessSMIInput.value = true;

            Navigator.of(context).pushReplacementNamed(
              authState.route,
            );
          } else if (authState is UnAuthenticatedState &&
              authState.errorMessage != null) {
            _trigFailSMIInput.value = true;

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
                  SizedBox(
                    height: utils.threeHundredDotNil,
                    width: utils.eightHundredDotNil,
                    child: RiveAnimation.asset(
                      utils.animatedLoginCharacterRiveAsset,
                      onInit: _onInit,
                    ),
                  ),
                  Text(
                    utils.signInText,
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
                                    _isCheckingSMIInput.value = true;
                                  } else {
                                    _isCheckingSMIInput.value = false;
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
                                  onChanged: (value) {
                                    _numLookSMIInput.value =
                                        value.length.toDouble();
                                  },
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
                                      _isHandsUpSMIInput.value = true;
                                    } else {
                                      _isHandsUpSMIInput.value = false;
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
                                        authCtx.read<AuthCubit>().signIn(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                            );
                                      } else {
                                        _trigFailSMIInput.value = true;
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
                                          utils.signInText,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            BlocBuilder<CategoryCubit, CategoryState>(
                              builder: (_, categoryState) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  categoryState.category == utils.Category.child
                                      ? const SizedBox(
                                          width: utils.nil,
                                          height: utils.nil,
                                        )
                                      : const SizedBox(
                                          height: utils.largePadding,
                                        ),
                                  categoryState.category == utils.Category.child
                                      ? const SizedBox(
                                          width: utils.nil,
                                          height: utils.nil,
                                        )
                                      : RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: utils
                                                    .newToClosrQuestionText,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: utils.whiteSpaceText,
                                              ),
                                              TextSpan(
                                                text: utils.signUpText,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        BlocProvider.of<
                                                            ScreenToShowCubit>(
                                                          context,
                                                        ).setScreenToShow(
                                                          utils.ScreenToShow
                                                              .signUp,
                                                        );
                                                      },
                                              ),
                                            ],
                                          ),
                                        ),
                                  categoryState.category == utils.Category.child
                                      ? const SizedBox(
                                          width: utils.nil,
                                          height: utils.nil,
                                        )
                                      : const SizedBox(
                                          height: utils.largePadding,
                                        ),
                                  categoryState.category == utils.Category.child
                                      ? const SizedBox(
                                          width: utils.nil,
                                          height: utils.nil,
                                        )
                                      : Row(
                                          children: [
                                            const Expanded(
                                              child: Divider(
                                                height: utils.veryTinyPadding,
                                                thickness:
                                                    utils.veryTinyPadding,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: utils.smallPadding,
                                              ),
                                              child: Text(
                                                utils.orText,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ),
                                            const Expanded(
                                              child: Divider(
                                                height: utils.veryTinyPadding,
                                                thickness:
                                                    utils.veryTinyPadding,
                                              ),
                                            ),
                                          ],
                                        ),
                                  const SizedBox(
                                    height: utils.largePadding,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: utils.goBackToText,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: utils.whiteSpaceText,
                                  ),
                                  TextSpan(
                                    text:
                                        utils.selectCategoryText.toLowerCase(),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        BlocProvider.of<ScreenToShowCubit>(
                                          context,
                                        ).setScreenToShow(
                                          utils.ScreenToShow.selectCategory,
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
