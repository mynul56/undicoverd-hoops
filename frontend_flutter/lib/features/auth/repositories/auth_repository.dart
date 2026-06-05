import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_client.dart';
// import '../models/user_model.dart'; // TODO: Implement UserModel

// Mock User Model for compilation
class User {
  final String id;
  final String email;
  User({required this.id, required this.email});
}

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, void>> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;

  AuthRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final response = await apiClient.dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.data['success'] == true) {
        final userData = response.data['data']['user'];
        return Right(User(id: userData['id'], email: userData['email']));
      } else {
        return Left(ServerFailure(response.data['error']['message'] ?? 'Login failed'));
      }
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to server'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await apiClient.dio.post('/auth/logout');
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Failed to logout'));
    }
  }
}
