// import 'dart:developer';

// import 'package:calc_app/delete_vers/model/user.dart';
// import 'package:calc_app/delete_vers/services/user_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';

// part 'user_event.dart';
// part 'user_state.dart';

// class UserBloc extends Bloc<UserEvent, UserState> {
//   final UserRepository userRepository;

//   UserBloc(this.userRepository) : super(UserStateInit()) {
//     on<UserEventLoad>((event, emit) async {
//       // log('1111111');

//       emit(UserStateLoading());
//       try {
//         await Future.delayed(const Duration(seconds: 6));
//         log('2222222');
//         final List<User> _loadedUserList = await userRepository.getAllUsers();
//         userRepository.updateList(_loadedUserList);
//         // log('before emit UserStateLoaded');
//         emit(UserStateLoaded(
//             loadedUser: /*_loadedUserList*/ userRepository.listUsers));
//         // log('after emit UserStateLoaded');
//       } catch (_) {
//         log('3333333');
//         emit(UserStateError());
//       }
//     });
//   }
// }


// // class UserBloc extends Bloc<UserEvent, UserState> {
// //   final UsersRepository usersRepository;

// //   UserBloc(this.usersRepository) : super(UserEmptyState()) {
// //     on<UserLoadEvent>((event, emit) async {
// //       emit(UserLoadingState());
// //       try {
// //         final List<User> _loadedUserList = await usersRepository.getAllUsers();
// //         emit(UserLoadedState(loadedUser: _loadedUserList));
// //       } catch (_) {
// //         emit(UserErrorState());
// //       }
// //     });
// //     on<UserClearEvent>((event, emit) async {
// //       emit(UserEmptyState());
// //     });
// //   }
// // }
