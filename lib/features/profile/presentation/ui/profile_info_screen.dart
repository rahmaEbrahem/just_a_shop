import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/profile/data/repo/profile_repo.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                _readOnlyField(LocaleKeys.firstname.tr(), user.firstName),
                _readOnlyField(LocaleKeys.lastname.tr(), user.lastName),
                _readOnlyField(LocaleKeys.nametitle.tr(), user.username),
                _readOnlyField(LocaleKeys.emailtitle.tr(), user.email),

                _editableField(
                  LocaleKeys.country.tr(),
                  countryController,
                  countryFocusNode,
                ),
                _editableField(
                  LocaleKeys.city.tr(),
                  cityController,
                  cityFocusNode,
                ),
                _editableField(
                  LocaleKeys.adress.tr(),
                  addressController,
                  addressFocusNode,
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
                      ? SizedBox(
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

  Widget _readOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: value,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _editableField(
    String label,
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    final isEditing = editingField == label;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        readOnly: !isEditing,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: isEditing
              ? primaryColor.withValues(alpha: 0.08)
              : Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isEditing ? Icons.check_circle_outline : Icons.edit_outlined,
              color: isEditing ? primaryColor : null,
            ),
            onPressed: () {
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
            },
          ),
        ),
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  final String label;
  final String value;

  const _InfoField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          8.verticalSpace,
          TextFormField(
            initialValue: value,
            readOnly: true,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }
}
