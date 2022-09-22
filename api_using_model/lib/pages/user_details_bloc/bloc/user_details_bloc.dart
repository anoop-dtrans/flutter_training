import 'dart:async';

import 'package:api_using_model/models/user.dart';
import 'package:api_using_model/models/users_post_details.dart';
import 'package:api_using_model/services/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc(int userId) : super(UserDetailsState(userId: userId)) {
    on<FetchInitialDataEvent>(_onFetchInitialDataEvent);
    on<FetchUserPostsEvent>(_onFetchUserPostsEvent);
  }

  FutureOr<void> _onFetchInitialDataEvent(
      FetchInitialDataEvent event, Emitter<UserDetailsState> emit) async {
    final user = await ApiService().getUserDetails(state.userId);
    final posts = await ApiService().getUserPosts(state.userId);
    emit(state.copyWith(user: user, posts: posts));
  }

  FutureOr<void> _onFetchUserPostsEvent(
      FetchUserPostsEvent event, Emitter<UserDetailsState> emit) async {
    final posts = await ApiService().getUserPosts(state.userId);
    emit(state.copyWith(posts: posts));
  }
}
