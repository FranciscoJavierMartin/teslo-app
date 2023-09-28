import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/features/auth/domain/domain.dart';
import 'package:teslo_app/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_app/features/auth/infrastructure/repositories/auth_repository_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) =>
    AuthNotifier(authRepository: AuthRepositoryImpl(AuthDataSourceImpl())));

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRespository authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthState());

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on WrongCredentials {
      logout('Invalid credentials');
    } catch (e) {
      logout('Unhandled error');
    }
  }

  void registerUser(String email, String password) async {}

  void checkStatus(String email, String password) async {}

  Future<void> logout([String? errorMessage]) async {
    state = state.copyWith(
      authStatus: AuthStatus.nonAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }

  void _setLoggedUser(User user) {
    state = state.copyWith(user: user, errorMessage: '');
  }
}

enum AuthStatus { checking, authenticated, nonAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
