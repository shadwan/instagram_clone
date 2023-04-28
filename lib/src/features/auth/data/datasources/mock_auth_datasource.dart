import 'dart:async';
import 'dart:math';

import '../../../../shared/domain/entities/user.dart';
import '../../domain/entities/logged_in_user.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

abstract class MockAuthDatasource {
  Stream<AuthStatus> get status;
  Future<LoggedInUser> get loggedInUser;
  Future<void> signup({required LoggedInUser loggedInUser});
  Future<void> login({
    required Username username,
    required Password password,
  });
  Future<void> logout();
}

class MockAuthDatasourceImpl extends MockAuthDatasource {
  MockAuthDatasourceImpl({CacheClient? cache})
      : _cache = cache ?? CacheClient();

  final CacheClient _cache;

  final _controller = StreamController<AuthStatus>();

  static const userCacheKey = '__user_cache_key';

  @override
  Future<LoggedInUser> get loggedInUser {
    return Future.delayed(const Duration(microseconds: 300), () {
      return _cache.read(key: userCacheKey) ?? LoggedInUser.empty;
    });
  }

  @override
  Future<void> login({required Username username, required Password password}) {
    return Future.delayed(const Duration(microseconds: 300), () {
      for (final user in _allUsers) {
        _updateLoggedInUser(
          id: user.id,
          username: user.username,
        );
        if (user.username.value == username.value) {
          _controller.add(AuthStatus.authenticated);
          return;
        }
      }
    });
  }

  @override
  Future<void> logout() {
    return Future.delayed(const Duration(microseconds: 300), () {
      _cache.write(key: userCacheKey, value: LoggedInUser.empty);
      _controller.add(AuthStatus.unauthenticated);
    });
  }

  @override
  Future<void> signup({required LoggedInUser loggedInUser}) {
    return Future.delayed(const Duration(microseconds: 300), () {
      _allUsers.add(loggedInUser);
      _updateLoggedInUser(
        id: loggedInUser.id,
        username: loggedInUser.username,
        email: loggedInUser.email,
      );
      _controller.add(AuthStatus.unauthenticated);
    });
  }

  @override
  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  final List<User> _allUsers = <User>[
    const User(
      id: 'user_1',
      username: Username.dirty('Massimo'),
      imagePath: 'assets/images/image_1.jpg',
    ),
    const User(
      id: 'user_2',
      username: Username.dirty('Sarah'),
      imagePath: 'assets/images/image_2.jpg',
    ),
    const User(
      id: 'user_3',
      username: Username.dirty('John'),
      imagePath: 'assets/images/image_3.jpg',
    ),
  ];

  void _updateLoggedInUser({String? id, Username? username, Email? email}) {
    LoggedInUser loggedInUser =
        _cache.read(key: userCacheKey) ?? LoggedInUser.empty;

    _cache.write(
        key: userCacheKey,
        value: loggedInUser.copyWith(
          id: id ?? loggedInUser.id,
          username: username ?? loggedInUser.username,
          email: email ?? loggedInUser.email,
        ));
  }
}

class CacheClient {
  CacheClient() : _cache = <String, dynamic>{};

  final Map<String, dynamic> _cache;

  void write<T extends Object>({
    required String key,
    required T value,
  }) {
    _cache[key] = value;
  }

  T? read<T extends Object>({
    required String key,
  }) {
    final value = _cache[key];
    if (value is T) {
      return value;
    }
    return null;
  }
}
