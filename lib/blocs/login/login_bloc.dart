import 'package:cinerate/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        final querySnapshot = await FirebaseFirestore.instance
            .collection('User')
            .where('name', isEqualTo: event.name)
            .where('password', isEqualTo: event.password)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          final user = querySnapshot.docs.first.data();
          emit(LoggedIn(User(name: user['name'], password: user['password'])));
        } else {
          emit(LoginError('Utilisateur non trouvé'));
        }
      }catch(e){
        emit(LoginError(e.toString()));
      }
    });

    on<LogOutEvent>((event, emit){
      emit(const LoggedOut());
    });
  }
}
