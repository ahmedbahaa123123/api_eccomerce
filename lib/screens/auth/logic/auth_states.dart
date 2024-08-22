abstract class AuthStates{}

class AuthInitial extends AuthStates{}
class AuthError extends AuthStates{
  AuthError(param0);
}
class AuthLoading extends AuthStates{}
class AuthSuccess extends AuthStates{}