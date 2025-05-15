import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_health_appointment/core/router/route_app.dart';
import 'package:mini_health_appointment/core/shared/cached_image_widget.dart';
import 'package:mini_health_appointment/core/theme/text_style_ext.dart';
import 'package:mini_health_appointment/core/translations/locale_keys.g.dart';
import 'package:mini_health_appointment/features/auth/presentation/blocs/logout/logout_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/shared/shimmer_widget.dart';
import '../../../home/presentation/widgets/custom_error_widget.dart';
import '../blocs/profile_bloc/profile_bloc.dart';
import '../widgets/profile_list_tile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfile());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LogoutBloc, LogoutState>(
          listener: (context, state) {
            if (state is LogoutSuccessful) {
              context.goNamed(RouteName.landing);
            } else if (state is LogoutFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.exception.message)));
            }
          },
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            LocaleKeys.profile.tr(),
            style:
                Theme.of(context).textTheme.headlineSmall?.onPrimary(context),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: PhosphorIcon(
                PhosphorIconsFill.bell,
                size: 24,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height / 3,
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height / 4.5),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                                blurRadius: 20,
                                offset: const Offset(0, 4))
                          ],
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).colorScheme.surface),
                      child: Transform.translate(
                        offset: const Offset(0, -50),
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: switch (state) {
                                    ProfileInitial() => const SizedBox(),
                                    ProfileLoading() => const _ProfileShimmer(),
                                    ProfileLoaded() => Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 100,
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .outlineVariant),
                                                child: CachedImageWidget(
                                                  errorWidget: (p0, p1, p2) =>
                                                      Text("data"),
                                                  nullWidget: PhosphorIcon(
                                                    PhosphorIconsDuotone
                                                        .userCircle,
                                                    size: 65,
                                                    duotoneSecondaryColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                  ),
                                                  uri: state.profile.imagepath,
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: PhosphorIcon(
                                                    PhosphorIconsFill
                                                        .pencilSimple,
                                                    size: 16,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            state.profile.fullname,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            state.profile.email,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ProfileFailed(:final exception) =>
                                      CustomErrorWidget(
                                        exception: exception,
                                      ),
                                  },
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                const Divider(),
                                SizedBox(
                                  height: 16,
                                ),
                                ProfileListTileWidget(
                                  leading: PhosphorIconsFill.pencilSimpleLine,
                                  title: LocaleKeys.edit_profile.tr(),
                                ),
                                ProfileListTileWidget(
                                  leading: PhosphorIconsFill.gearSix,
                                  title: LocaleKeys.setting.tr(),
                                ),
                                ProfileListTileWidget(
                                  leading: PhosphorIconsFill.signOut,
                                  title: LocaleKeys.logout.tr(),
                                  withColor:
                                      Theme.of(context).colorScheme.error,
                                  onTap: () {
                                    context
                                        .read<LogoutBloc>()
                                        .add(LogoutRequested());
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ProfileShimmer extends StatelessWidget {
  const _ProfileShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: const ShimmerWidget(
              width: 100,
              height: 100,
            )),
        SizedBox(
          height: 16,
        ),
        ShimmerWidget(
          width: MediaQuery.sizeOf(context).width / 3,
          height: 21,
        ),
        SizedBox(
          height: 16,
        ),
        ShimmerWidget(
          width: MediaQuery.sizeOf(context).width / 2,
          height: 18,
        ),
        SizedBox(
          height: 16,
        ),
        const ShimmerWidget(
          width: 70,
          height: 28,
        ),
      ],
    );
  }
}
