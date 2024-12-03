import 'package:cinerate/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(const LoggedOut()) {
    on<LogInEvent>((event, emit) async {
      if (event.name.trim().isEmpty || event.password.trim().isEmpty) {
        emit(LoginError('Le nom et le mot de passe ne peuvent pas être vides'));
        return;
      }
      try{
        emit( const LoggingIn());
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: event.name, password: event.password);
        if (credential.user != null) {
          emit(LoggedIn(Users(name:credential.user!.email!)));
        } else {
          emit(LoginError('Utilisateur non trouvé. Veuillez vérifier vos informations'));
        }
      }catch(e){
        emit(LoginError("Utilisateur non trouvé. Veuillez réessayer"));
      }
    });

    on<LogOutEvent>((event, emit){
      emit(const LoggedOut());
    });
  }
}
