part of 'user_details_bloc.dart';

abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchInitialDataEvent extends UserDetailsEvent {}

class FetchUserPostsEvent extends UserDetailsEvent {}
