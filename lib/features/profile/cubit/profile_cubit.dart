import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bookia/features/profile/data/models/profile_model.dart';
import 'package:bookia/features/profile/data/repositories/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(const ProfileInitial());

  Future<void> getProfile() async {
    try {
      emit(const ProfileLoading());
      final profile = await _repository.getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? avatar,
  }) async {
    try {
      emit(const ProfileUpdating());
      final profile = await _repository.updateProfile(
        name: name,
        phone: phone,
        avatar: avatar,
      );
      emit(ProfileUpdated(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      emit(const ProfileResettingPassword());
      await _repository.resetPassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      emit(const ProfilePasswordReset());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
