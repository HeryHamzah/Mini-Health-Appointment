import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_health_appointment/core/extensions/app_info_ext.dart';
import 'package:mini_health_appointment/core/extensions/red_asterisk_extension.dart';
import 'package:mini_health_appointment/core/router/route_app.dart';
import 'package:mini_health_appointment/core/theme/text_style_ext.dart';
import 'package:mini_health_appointment/core/translations/locale_keys.g.dart';
import 'package:mini_health_appointment/core/utils/functions.dart';
import 'package:mini_health_appointment/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/shared/full_screen_loading_widget.dart';
import '../../../../core/shared/outlined_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  login() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(LoginWithEmailAndPasswordRequested(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.goNamed(RouteName.main);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.exception.message)));
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              body: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        physics: const ClampingScrollPhysics(),
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 80,
                              ),
                              Text(
                                LocaleKeys.welcome_to
                                    .tr(args: [context.appName]),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                LocaleKeys.login_desc.tr(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  LocaleKeys.email.tr(),
                                  style: Theme.of(context).textTheme.labelLarge,
                                ).withRedAsterisk(context),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              OutlinedTextField(
                                controller: _emailController,
                                hintText: "example@email.com",
                                validator: emailValidator,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  LocaleKeys.password.tr(),
                                  style: Theme.of(context).textTheme.labelLarge,
                                ).withRedAsterisk(context),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              OutlinedTextField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                suffixIcon: IconButton(
                                  iconSize: 20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inverseSurface,
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: _obscureText
                                      ? const PhosphorIcon(
                                          PhosphorIconsFill.eyeSlash)
                                      : const PhosphorIcon(
                                          PhosphorIconsFill.eye),
                                ),
                                hintText: LocaleKeys.input_password.tr(),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return LocaleKeys
                                        .form_validation_empty_password
                                        .tr();
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 55,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                child: FilledButton(
                                    onPressed: login,
                                    child: Text(
                                      LocaleKeys.login.tr(),
                                    )),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.dont_have_account.tr(),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.goNamed(RouteName.register);
                                    },
                                    child: Text(
                                      LocaleKeys.sign_up.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.primary(context)
                                          .underline(context),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (state is AuthLoading) const FullScreenLoadingWidget()
          ],
        );
      },
    );
  }
}
