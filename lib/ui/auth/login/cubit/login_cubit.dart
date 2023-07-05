import 'package:app_creaty_mobile/commons/enums/loading_status.dart';
import 'package:app_creaty_mobile/domain/repository/auth_repository.dart';
import 'package:app_creaty_mobile/ui/app/app.dart';
import 'package:app_creaty_mobile/ui/auth/login/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required AuthRepository authRepository, required AppBloc appBloc})
      : _authRepository = authRepository,
        _appBloc = appBloc,
        super(const LoginState());

  final AuthRepository _authRepository;

  final AppBloc _appBloc;

  Future<void> login({required String email, required String password}) async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final user = await _authRepository.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(state.copyWith(loadingStatus: LoadingStatus.done));
      _appBloc.add(ChangeUser(user: user));
    } catch (e) {
      addError(e);
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    }
  }
}
