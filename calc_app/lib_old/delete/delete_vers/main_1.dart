// import 'package:calc_app/delete_vers/services/user_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'bloc/user_bloc.dart';

// // void main() {
// //   runApp(App());
// // }

// class App extends StatelessWidget {
//   final usersRepository = UserRepository();

//   App({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: BlocProvider<UserBloc>(
//         create: (context) => UserBloc(usersRepository),
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('asf'),
//           ),
//           body: const GeneralPage(),
//         ),
//       ),
//     );
//   }
// }

// class GeneralPage extends StatelessWidget {
//   const GeneralPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<UserBloc>(context).add(UserEventLoad());

//     /*
//     final UserBloc userBloc = context.read<UserBloc>();
//     userBloc.add(UserEventLoad());
//     */
//     return BlocBuilder<UserBloc, UserState>(
//       builder: (context, state) {
//         if (state is UserStateLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (state is UserStateLoaded) {
//           return ListView.builder(
//             itemCount: state.loadedUser.length,
//             itemBuilder: (context, index) => GestureDetector(
//               // onTap: () {
//               //   userBloc.add(UserEventLoad());
//               // },
//               child: Container(
//                 color: iterateColor(index),
//                 child: Text(
//                   state.loadedUser[index].toString(),
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           );
//         }
//         if (state is UserStateError) {
//           return const Center(
//             child: Text(
//               'Error fetching users',
//               style: TextStyle(fontSize: 20.0),
//             ),
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }

//   Color iterateColor(int index) {
//     return (index % 2 == 0 ? Colors.white : Colors.blue[50])!;
//   }
// }
