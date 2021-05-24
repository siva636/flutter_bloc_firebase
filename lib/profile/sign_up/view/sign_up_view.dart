import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase/profile/sign_up/bloc/sign_up_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter/foundation.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: SignUpForm()));
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<SignUpBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<SignUpBloc>().add(PasswordUnfocused());
      }
    });
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        context.read<SignUpBloc>().add(NameUnfocused());
      }
    });
    _ageFocusNode.addListener(() {
      if (!_ageFocusNode.hasFocus) {
        context.read<SignUpBloc>().add(AgeUnfocused());
      }
    });
    _genderFocusNode.addListener(() {
      if (!_genderFocusNode.hasFocus) {
        context.read<SignUpBloc>().add(GenderUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _ageFocusNode.dispose();
    _genderFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Success...')),
            );
          Navigator.of(context).pushNamed('/dashboard');
        }
        if (state.status.isSubmissionInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Submitting...')),
            );
        }
      },
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: kIsWeb ? 500 : double.infinity),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Create Account,',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text('Sign up to get started!',
                    style: Theme.of(context).textTheme.headline4),
                Spacer(flex: 4),
                Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: EmailInput(focusNode: _emailFocusNode)),
                Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: PasswordInput(focusNode: _passwordFocusNode)),
                Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: NameInput(focusNode: _nameFocusNode)),
                Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: AgeInput(focusNode: _ageFocusNode)),
                Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: GenderInput(focusNode: _genderFocusNode)),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: SubmitButton(),
                      )
                    ],
                  ),
                ),
                Spacer(flex: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("I'm already a member,"),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key key, this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          initialValue: state.email.value,
          focusNode: focusNode,
          onChanged: (value) {
            context.read<SignUpBloc>().add(EmailChanged(email: value));
          },
          // textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.email.invalid ? 'Enter a valid email' : null,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.all(20),
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key key, this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.visiblePassword,
          initialValue: state.password.value,
          focusNode: focusNode,
          obscureText: true,
          onChanged: (value) {
            context.read<SignUpBloc>().add(PasswordChanged(password: value));
          },
          // textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: state.password.invalid
                ? 'Password must have at least 6 characters'
                : null,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.all(20),
          ),
        );
      },
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({Key key, this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.name,
          initialValue: state.name.value,
          focusNode: focusNode,
          onChanged: (value) {
            context.read<SignUpBloc>().add(NameChanged(name: value));
          },
          // textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: state.name.invalid ? 'Enter a valid name' : null,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.all(20),
          ),
        );
      },
    );
  }
}

class AgeInput extends StatelessWidget {
  const AgeInput({Key key, this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.number,
          initialValue: state.age.value,
          focusNode: focusNode,
          onChanged: (value) {
            context.read<SignUpBloc>().add(AgeChanged(age: value));
          },
          // textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Age',
            errorText: state.age.invalid ? 'Enter a valid age' : null,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.all(20),
          ),
        );
      },
    );
  }
}

class GenderInput extends StatelessWidget {
  const GenderInput({Key key, this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          initialValue: state.gender.value,
          focusNode: focusNode,
          onChanged: (value) {
            context.read<SignUpBloc>().add(GenderChanged(gender: value));
          },
          // textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Gender',
            errorText:
                state.gender.invalid ? 'Enter either male or female' : null,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.all(20),
          ),
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          style: ButtonStyle(shape: MaterialStateProperty.all(StadiumBorder())),

          onPressed: state.status.isValidated &&
                  !state.status.isSubmissionInProgress &&
                  !state.status.isSubmissionSuccess
              ? () => context.read<SignUpBloc>().add(FormSubmitted())
              : null,

          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Submit',
              style: TextStyle(fontSize: 20),
            ),
          ),
          // textTheme: ButtonTextTheme.accent,
        );
      },
    );
  }
}
