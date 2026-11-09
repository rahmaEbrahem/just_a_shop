import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/profile/data/repo/profile_repo.dart';
import 'package:e_commerce_app/features/profile/presentation/ui/widgets/profile_fields_list.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/profile_cubit.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  String? editingField;

  final countryFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final addressFocusNode = FocusNode();

  bool fieldsInitialized = false;
  bool isSaving = false;

  @override
  void dispose() {
    countryController.dispose();
    cityController.dispose();
    addressController.dispose();
    countryFocusNode.dispose();
    cityFocusNode.dispose();
    addressFocusNode.dispose();

    super.dispose();
  }

  void fillFields(ProfileSuccess state) {
    if (fieldsInitialized) return;

    countryController.text = state.user.country;
    cityController.text = state.user.city;
    addressController.text = state.user.address;

    fieldsInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(ProfileRepo())..getUserProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              LocaleKeys.personalinformation.tr(),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColor.maincolor),
            ),
          ),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccess) {
              fillFields(state);

              if (isSaving) {
                setState(() => isSaving = false);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(LocaleKeys.addressupdated.tr())),
                );
              }
            }

            if (state is ProfileError && isSaving) {
              setState(() => isSaving = false);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure.failureMessage)),
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading && !fieldsInitialized) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError && !fieldsInitialized) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.failure.failureMessage),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileCubit>().getUserProfile();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final cubit = context.read<ProfileCubit>();
            final user = cubit.userProfile;

            if (user == null) {
              return const SizedBox.shrink();
            }

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                ProfileFieldsList(
                  user: user,
                  countryController: countryController,
                  cityController: cityController,
                  addressController: addressController,
                  countryFocusNode: countryFocusNode,
                  cityFocusNode: cityFocusNode,
                  addressFocusNode: addressFocusNode,
                  editingField: editingField,
                  onToggleEdit: _handleEditToggle,
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: isSaving
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();
                          setState(() => isSaving = true);

                          await context.read<ProfileCubit>().updateUserProfile(
                            country: countryController.text.trim(),
                            city: cityController.text.trim(),
                            address: addressController.text.trim(),
                          );
                        },
                  child: isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(LocaleKeys.savechange.tr()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleEditToggle(String label, FocusNode focusNode) {
    final isEditing = editingField == label;
    if (isEditing) {
      setState(() {
        editingField = null;
      });
      focusNode.unfocus();
    } else {
      setState(() {
        editingField = label;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        focusNode.requestFocus();
      });
    }
  }
}