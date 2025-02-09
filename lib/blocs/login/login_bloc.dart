import 'package:cinerate/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(const LoggedOut()) {
    on<LogInEvent>((event, emit) async {
      if (event.name.trim().isEmpty || event.password.trim().isEmpty) {
        emit(LoginError('Veuillez remplir tous les champs'));
        return;
      }
      try{
        emit( const LoggingIn());
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: event.name, password: event.password);
        if (credential.user != null) {
          emit(LoggedIn(Users(name:credential.user!.email!)));
        } else {
          emit(LoginError("L'utilisateur n'existe pas"));
        }
      }catch(e){
        emit(LoginError("Une erreur s'est produite. Veuillez réessayer"));
      }
    });

    on<LogOutEvent>((event, emit){
      emit(const LoggedOut());
    });

    on<RegisterEvent>((event, emit) async {
      if (event.name.trim().isEmpty || event.password.trim().isEmpty) {
        emit(LoginError('Veuillez remplir tous les champs'));
        return;
      }
      try{
        emit(const Registering());
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: event.name, password: event.password);
        if (credential.user != null) {
          emit(LoggedIn(Users(name: credential.user!.email!)));
        } else {
          emit(LoginError("Une erreur s'est produite lors de l'inscription."));
        }
      } on FirebaseAuthException catch(e){
        if (e.code == 'email-already-in-use') {
          emit(LoginError('L\'e-mail est déjà utilisé.'));
        } else if (e.code == 'invalid-email') {
          emit(LoginError('L\'e-mail est invalide.'));
        } else {
          emit(LoginError("Une erreur s'est produite. Veuillez réessayer"));
        }
      } catch(e){
        emit(LoginError("Une erreur s'est produite. Veuillez réessayer"));
      }
    });
  }
}
