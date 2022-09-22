part of 'user_details_cubit.dart';

class UserDetailsState extends Equatable {
  const UserDetailsState({
    required this.userId,
    this.user = User.empty,
    this.posts = const [],
    this.isBusy = false,
    this.errorMessage,
  });

  /// Required to get started
  final int userId;

  final User user;

  final List<UsersPost> posts;

  final bool isBusy;

  final String? errorMessage;

  bool get hasError => errorMessage?.isNotEmpty ?? false;

  /// Create a copy of state with provided params
  UserDetailsState copyWith(
      {int? userId,
      User? user,
      List<UsersPost>? posts,
      bool? isBusy,
      String? errorMessage}) {
    return UserDetailsState(
      userId: userId ?? this.userId,
      user: user ?? this.user,
      posts: posts ?? this.posts,
      isBusy: isBusy ?? this.isBusy,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        user,
        posts,
        isBusy,
        errorMessage,
      ];
}
