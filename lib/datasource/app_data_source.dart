import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../datasource/data_source.dart';
import '../models/app_user.dart';
import '../models/auth_response_model.dart';
import '../models/bus_model.dart';
import '../models/bus_reservation.dart';
import '../models/bus_route.dart';
import '../models/bus_schedule.dart';
import '../models/error_details.dart';
import '../models/response_model.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class AppDataSource extends DataSource {
  // final String baseUrl = 'http://10.0.2.2:8080/api/';
  final String baseUrl = 'http://192.168.1.140:8080/api/';

  Map<String, String> get header => {'Content-Type': 'application/json'};

  Future<Map<String, String>> get authHeader async => {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ${await getToken()}'
      };

  @override
  Future<ResponseModel> addBus(Bus bus) async {
    final url = '$baseUrl${'bus/add'}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: await authHeader,
        body: json.encode(bus.toJson()),
      );
      return await _getResponseModel(response);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<ResponseModel> addReservation(BusReservation reservation) {
    // TODO: implement addReservation
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> addRoute(BusRoute busRoute) {
    // TODO: implement addRoute
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> addSchedule(BusSchedule busSchedule) {
    // TODO: implement addSchedule
    throw UnimplementedError();
  }

  @override
  Future<List<Bus>> getAllBus() {
    // TODO: implement getAllBus
    throw UnimplementedError();
  }

  @override
  Future<List<BusReservation>> getAllReservation() {
    // TODO: implement getAllReservation
    throw UnimplementedError();
  }

  @override
  Future<List<BusRoute>> getAllRoutes() {
    // TODO: implement getAllRoutes
    throw UnimplementedError();
  }

  @override
  Future<List<BusSchedule>> getAllSchedules() {
    // TODO: implement getAllSchedules
    throw UnimplementedError();
  }

  @override
  Future<List<BusReservation>> getReservationsByMobile(String mobile) {
    // TODO: implement getReservationsByMobile
    throw UnimplementedError();
  }

  @override
  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) {
    // TODO: implement getReservationsByScheduleAndDepartureDate
    throw UnimplementedError();
  }

  @override
  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) {
    // TODO: implement getRouteByCityFromAndCityTo
    throw UnimplementedError();
  }

  @override
  Future<BusRoute?> getRouteByRouteName(String routeName) {
    // TODO: implement getRouteByRouteName
    throw UnimplementedError();
  }

  @override
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) {
    // TODO: implement getSchedulesByRouteName
    throw UnimplementedError();
  }

  @override
  Future<AuthResponseModel?> login(AppUser user) async {
    final url = '$baseUrl${'auth/login'}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: json.encode(user.toJson()),
      );
      final map = json.decode(response.body);
      debugPrint('Login Response: $map');
      final authResponseModel = AuthResponseModel.fromJson(map);
      return authResponseModel;
    } catch (error) {
      debugPrint('Login Error: $error');
      return null;
    }
  }

  Future<ResponseModel> _getResponseModel(http.Response response) async {
    ResponseStatus status = ResponseStatus.NONE;
    ResponseModel responseModel = ResponseModel();
    if (response.statusCode == 200) {
      status = ResponseStatus.SAVED;
      responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      responseModel.responseStatus = status;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      if (await hasTokenExpired()) {
        status = ResponseStatus.EXPIRED;
      } else {
        status = ResponseStatus.UNAUTHORIZED;
      }
      responseModel = ResponseModel(
          responseStatus: status,
          statusCode: 401,
          message: 'Access denied. Please login as admin');
    } else if (response.statusCode == 500 || response.statusCode == 400) {
      final json = jsonDecode(response.body);
      final errorDetails = ErrorDetails.fromJson(json);
      status = ResponseStatus.FAILED;
      responseModel = ResponseModel(
          responseStatus: status,
          statusCode: 500,
          message: errorDetails.errorMessage);
    }
    return responseModel;
  }
}
