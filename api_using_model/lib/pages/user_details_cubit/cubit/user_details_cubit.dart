import 'package:api_using_model/models/user.dart';
import 'package:api_using_model/models/users_post_details.dart';
import 'package:api_using_model/services/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit(int userId) : super(UserDetailsState(userId: userId));

  Future<void> initialize() async {
    await getUserDetails();
    await getUserPosts();
  }

  Future<void> getUserDetails() async {
    final user = await ApiService().getUserDetails(state.userId);
    emit(state.copyWith(user: user));
  }

  Future<void> getUserPosts() async {
    final posts = await ApiService().getUserPosts(state.userId);
    emit(state.copyWith(posts: posts));
  }
}
