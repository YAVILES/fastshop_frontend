import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Storage {
  static late GetStorage storage;

  static Future<GetStorage> configureStorage() async {
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();
    storage = GetStorage();
    return storage;
  }

  static Future<void> setToken(String token, String? refresh) async {
    storage.write("token", token);
    storage.write("refresh", refresh ?? "");
  }

  static Future<void> setSchema(String schema) async {
    storage.write("schema", schema);
  }

  static String? getSchema() {
    return storage.read("schema");
  }

  static void removetoken() async {
    storage.remove("token");
    storage.remove("refresh");
  }

  static String? getToken() {
    return storage.read("token");
  }

  static String? getRefreshToken() {
    return storage.read("refresh");
  }

  static Future<void> setIdUser(String id) async {
    storage.write("id_user", id);
  }

  static String? getIdUser() {
    return storage.read("id_user");
  }
}
