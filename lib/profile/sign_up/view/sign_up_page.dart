import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase/profile/sign_up/bloc/sign_up_bloc.dart';
import 'package:flutter_bloc_firebase/profile/sign_up/view/sign_up_view.dart';
import 'package:profile_repository/profile_repository.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
          profileRepository: RepositoryProvider.of<ProfileRepository>(context)),
      child: SignUpView(),
    );
  }
}
