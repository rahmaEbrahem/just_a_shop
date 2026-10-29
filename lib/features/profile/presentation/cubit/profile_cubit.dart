import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/error_handl/error_handling.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/features/profile/data/model/profile_model.dart';
import 'package:e_commerce_app/features/profile/data/repo/profile_repo.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  final ProfileRepo profileRepo;

  UserProfileModel? userProfile;

  Future<void> getUserProfile() async {
    emit(ProfileLoading());

    try {
      userProfile = await profileRepo.getUserProfile();
      emit(ProfileSuccess(userProfile!));
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(ProfileError(failure));
    }
  }

  Future<void> updateUserProfile({
    required String country,
    required String city,
    required String address,
  }) async {
    final currentUser = userProfile;

    if (currentUser == null) return;

    emit(ProfileLoading());

    try {
      await profileRepo.updateUserProfile(
        userId: currentUser.id,
        country: country,
        city: city,
        address: address,
      );

      userProfile = UserProfileModel(
        id: currentUser.id,
        firstName: currentUser.firstName,
        lastName: currentUser.lastName,
        username: currentUser.username,
        email: currentUser.email,
        country: country,
        city: city,
        address: address,
      );

      emit(ProfileSuccess(userProfile!));
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(ProfileError(failure));
    }
  }
}
