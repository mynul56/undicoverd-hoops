import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../shared/models/user_contract.dart';

// Mock User Model for compilation
class User {
  final String id;
  final String email;
  User({required this.id, required this.email});
}

abstract class AuthRepository {
  Future<Either<Failure, UserContract>> login(String email, String password);
  Future<Either<Failure, UserContract>> register(String email, String password, String role);
  Future<Either<Failure, void>> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;
  final _storage = const FlutterSecureStorage();

  AuthRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, UserContract>> login(String email, String password) async {
    // Demo bypass
    if (email == 'player@demo.com' || email == 'coach@demo.com') {
      final isCoach = email.contains('coach');
      final fakeToken = 'demo_jwt_token_${isCoach ? "coach" : "player"}';
      await _storage.write(key: 'jwt_token', value: fakeToken);
      
      return Right(UserContract(
        id: isCoach ? 'demo_coach_1' : 'demo_player_1',
        email: email,
        role: isCoach ? 'coach' : 'player',
      ));
    }

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
        final token = response.data['data']['accessToken'];
        if (token != null) await _storage.write(key: 'jwt_token', value: token);
        return Right(UserContract.fromJson(userData));
      } else {
        return Left(ServerFailure(response.data['error']?.toString() ?? 'Login failed'));
      }
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to server'));
    }
  }

  @override
  Future<Either<Failure, UserContract>> register(String email, String password, String role) async {
    try {
      final response = await apiClient.dio.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'role': role,
        },
      );

      if (response.data['success'] == true) {
        final userData = response.data['data']['user'];
        final token = response.data['data']['accessToken'];
        if (token != null) await _storage.write(key: 'jwt_token', value: token);
        return Right(UserContract.fromJson(userData));
      } else {
        return Left(ServerFailure(response.data['error']?.toString() ?? 'Registration failed'));
      }
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to server'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _storage.delete(key: 'jwt_token');
      await apiClient.dio.post('/auth/logout');
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Failed to logout'));
    }
  }
}
