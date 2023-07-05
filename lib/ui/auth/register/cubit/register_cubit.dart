
import 'package:app_creaty_mobile/commons/enums/loading_status.dart';
import 'package:app_creaty_mobile/domain/repository/auth_repository.dart';
import 'package:app_creaty_mobile/ui/auth/register/cubit/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const RegisterState());

  final AuthRepository _authRepository;

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    return _authRepository
        .registerWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (_) => emit(state.copyWith(loadingStatus: LoadingStatus.done)),
      onError: (_) {
        emit(state.copyWith(loadingStatus: LoadingStatus.error));
      },
    );
  }
}
