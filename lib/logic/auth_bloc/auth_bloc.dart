import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_shope_app/data/data_source/remote_data/auth_repository.dart';
import 'package:fake_shope_app/data/models/user_model.dart';
import 'package:fake_shope_app/utils/constant/app_text.dart';
import 'package:fake_shope_app/utils/helpers/shared_preferences_helper.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignUpEvent>(onSignUpEvent);
    on<LoginEvent>(onLogin);
  }

  Future<void> onSignUpEvent(SignUpEvent event, Emitter emit) async {
    try {
      emit(SignUpWaiting());
      Either<String, String> result =
          await authRepository.signup(user: event.user);
      await result.fold((left) async {
        await SharedPreferencesHelper().setToken(left);
        emit(SignUpSuccess(token: left));
      }, (right) async {
        emit(SignUpFailure(message: right));
      });
    } catch (e) {
      emit(const SignUpFailure(message: AppText.unKnownError));
    }
  }

  Future<void> onLogin(LoginEvent event, Emitter emit) async {
    try {
      emit(LoginWaiting());
      Either<String, String> result = await authRepository.login(
          email: event.email, password: event.password);
      await result.fold((left) async {
        await SharedPreferencesHelper().setToken(left);
        emit(LoginSuccess(token: left));
      }, (right) async {
        emit(LoginFailure(message: right));
      });
    } catch (e) {
      emit(const LoginFailure(message: AppText.unKnownError));
    }
  }
}
