import 'package:get_it/get_it.dart';

class Injector {
  // private constructor to avoid instantation
  Injector._internal();

  ///
  /// Original injector
  ///
  static final _injector = GetIt.instance;

  ///
  /// Get dependency
  ///
  static T get<T extends Object>() => _injector.get<T>();

  ///
  /// Register factory,
  /// returns new object each time
  ///
  static void registerFactory<T extends Object>(FactoryFunc<T> func) =>
      _injector.registerFactory(func);

  ///
  /// Register singleton lazily,
  /// will be registered only on first get
  ///
  static void registerLazySingleton<T extends Object>(FactoryFunc<T> func) =>
      _injector.registerLazySingleton(func);

  ///
  /// To register singleton instantly
  ///
  static void registerSingleton<T extends Object>(T instance) =>
      _injector.registerSingleton(instance);

  ///
  /// Clear all dependencies
  ///
  static void reset() => _injector.reset();
}
