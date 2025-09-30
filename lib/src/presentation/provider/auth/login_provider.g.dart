// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(loginRepositorie)
const loginRepositorieProvider = LoginRepositorieProvider._();

final class LoginRepositorieProvider
    extends
        $FunctionalProvider<
          LoginRepositories,
          LoginRepositories,
          LoginRepositories
        >
    with $Provider<LoginRepositories> {
  const LoginRepositorieProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginRepositorieProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginRepositorieHash();

  @$internal
  @override
  $ProviderElement<LoginRepositories> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LoginRepositories create(Ref ref) {
    return loginRepositorie(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginRepositories value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginRepositories>(value),
    );
  }
}

String _$loginRepositorieHash() => r'900181b25ceb5de8622d59024e81e229ec5a064e';

@ProviderFor(Register)
const registerProvider = RegisterProvider._();

final class RegisterProvider
    extends $AsyncNotifierProvider<Register, UserEntity?> {
  const RegisterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerHash();

  @$internal
  @override
  Register create() => Register();
}

String _$registerHash() => r'c84ee5757d3ecfb1d3d7c7a856f02ba69134a77d';

abstract class _$Register extends $AsyncNotifier<UserEntity?> {
  FutureOr<UserEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<UserEntity?>, UserEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserEntity?>, UserEntity?>,
              AsyncValue<UserEntity?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(TotalItems)
const totalItemsProvider = TotalItemsFamily._();

final class TotalItemsProvider extends $AsyncNotifierProvider<TotalItems, int> {
  const TotalItemsProvider._({
    required TotalItemsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'totalItemsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$totalItemsHash();

  @override
  String toString() {
    return r'totalItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TotalItems create() => TotalItems();

  @override
  bool operator ==(Object other) {
    return other is TotalItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$totalItemsHash() => r'0ff178fc7b49490a95246d517f4eca48d44b24fd';

final class TotalItemsFamily extends $Family
    with
        $ClassFamilyOverride<
          TotalItems,
          AsyncValue<int>,
          int,
          FutureOr<int>,
          String
        > {
  const TotalItemsFamily._()
    : super(
        retry: null,
        name: r'totalItemsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TotalItemsProvider call(String userId) =>
      TotalItemsProvider._(argument: userId, from: this);

  @override
  String toString() => r'totalItemsProvider';
}

abstract class _$TotalItems extends $AsyncNotifier<int> {
  late final _$args = ref.$arg as String;
  String get userId => _$args;

  FutureOr<int> build(String userId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<int>, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int>, int>,
              AsyncValue<int>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(Login)
const loginProvider = LoginProvider._();

final class LoginProvider extends $AsyncNotifierProvider<Login, UserEntity?> {
  const LoginProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginHash();

  @$internal
  @override
  Login create() => Login();
}

String _$loginHash() => r'6bf70b7c861ca7c168207df934f3d9b883ce0618';

abstract class _$Login extends $AsyncNotifier<UserEntity?> {
  FutureOr<UserEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<UserEntity?>, UserEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserEntity?>, UserEntity?>,
              AsyncValue<UserEntity?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
