import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_health_appointment/core/extensions/red_asterisk_extension.dart';
import 'package:mini_health_appointment/core/router/route_app.dart';
import 'package:mini_health_appointment/core/utils/functions.dart';
import 'package:mini_health_appointment/features/auth/domain/entities/user_type_enum.dart';
import 'package:mini_health_appointment/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/shared/full_screen_loading_widget.dart';
import '../../../../core/shared/outlined_text_field.dart';
import '../../../../core/translations/locale_keys.g.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _passwordObscureText = true;
  bool _confirmPasswordObscureText = true;
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  register() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(RegisterRequested(
            name: _fullnameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            userType: UserType.patient,
          ));
    }
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
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            LocaleKeys.patient.tr(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              LocaleKeys.register_desc.tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(
                            height: 38,
                          ),
                          Text(
                            LocaleKeys.full_name.tr(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ).withRedAsterisk(context),
                          SizedBox(
                            height: 10,
                          ),
                          OutlinedTextField(
                            controller: _fullnameController,
                            hintText: LocaleKeys.full_name.tr(),
                            validator: (p0) {
                              if (p0 == null || p0.trim().isEmpty) {
                                return LocaleKeys
                                    .form_validation_empty_full_name
                                    .tr();
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            LocaleKeys.email.tr(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ).withRedAsterisk(context),
                          SizedBox(
                            height: 10,
                          ),
                          OutlinedTextField(
                            controller: _emailController,
                            hintText: "Email@mail.com",
                            validator: emailValidator,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            LocaleKeys.password.tr(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ).withRedAsterisk(context),
                          SizedBox(
                            height: 10,
                          ),
                          OutlinedTextField(
                            controller: _passwordController,
                            hintText: LocaleKeys.input_password.tr(),
                            obscureText: _passwordObscureText,
                            suffixIcon: IconButton(
                              iconSize: 20,
                              onPressed: () {
                                setState(() {
                                  _passwordObscureText = !_passwordObscureText;
                                });
                              },
                              icon: _passwordObscureText
                                  ? const PhosphorIcon(
                                      PhosphorIconsFill.eyeSlash)
                                  : const PhosphorIcon(PhosphorIconsFill.eye),
                            ),
                            validator: passwordValidator,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            LocaleKeys.confirm_password.tr(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ).withRedAsterisk(context),
                          SizedBox(
                            height: 10,
                          ),
                          OutlinedTextField(
                            controller: _confirmPasswordController,
                            hintText: LocaleKeys.confirm_password.tr(),
                            obscureText: _confirmPasswordObscureText,
                            suffixIcon: IconButton(
                              iconSize: 20,
                              onPressed: () {
                                setState(() {
                                  _confirmPasswordObscureText =
                                      !_confirmPasswordObscureText;
                                });
                              },
                              icon: _confirmPasswordObscureText
                                  ? const PhosphorIcon(
                                      PhosphorIconsFill.eyeSlash)
                                  : const PhosphorIcon(PhosphorIconsFill.eye),
                            ),
                            validator: (p0) {
                              return confirmPasswordValidator(
                                  p0, _passwordController.text);
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          FilledButton(
                            onPressed: register,
                            child: Text(
                              LocaleKeys.submit.tr(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
