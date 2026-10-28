part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserProfileModel user;

  ProfileSuccess(this.user);
}

class ProfileError extends ProfileState {
  final Failure failure;

  ProfileError(this.failure);
}
