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
  Future<ResponseModel> addReservation(BusReservation reservation) async {
    final url = '$baseUrl${'reservation/add'}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: json.encode(
          reservation.toJson(),
        ),
      );
      return await _getResponseModel(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> addRoute(BusRoute busRoute) async {
    final url = '$baseUrl${'bus-route/add'}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: await authHeader,
        body: json.encode(busRoute.toJson()),
      );
      return await _getResponseModel(response);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<ResponseModel> addSchedule(BusSchedule busSchedule) async {
    final url = '$baseUrl${'schedule/add'}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: await authHeader,
        body: json.encode(busSchedule.toJson()),
      );
      return await _getResponseModel(response);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Bus>> getAllBus() async {
    final url = '$baseUrl${'bus/all'}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final mapList = json.decode(response.body) as List;
        return List.generate(
            mapList.length, (index) => Bus.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<BusReservation>> getAllReservation() async {
    final url = '$baseUrl${'reservation/all'}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final mapList = json.decode(response.body) as List;
        return List.generate(
            mapList.length, (index) => BusReservation.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<BusRoute>> getAllRoutes() async {
    final url = '$baseUrl${'bus-route/all'}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final mapList = json.decode(response.body) as List;
        return List.generate(
            mapList.length, (index) => BusRoute.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<BusSchedule>> getAllSchedules() {
    // TODO: implement getAllSchedules
    throw UnimplementedError();
  }

  @override
  Future<List<BusReservation>> getReservationsByMobile(String mobile) async {
    final url = '$baseUrl${'reservation/all/$mobile'}';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final mapList = json.decode(res.body) as List;
        return List.generate(
            mapList.length, (index) => BusReservation.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      return [];
    }

  }

  @override
  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) async {
    final url =
        '$baseUrl${'reservation/query?scheduleId=$scheduleId&departureDate=$departureDate'}';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final mapList = json.decode(res.body) as List;
        return List.generate(
            mapList.length, (index) => BusReservation.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  @override
  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) async {
    final url =
        '$baseUrl${'bus-route/query?cityFrom=$cityFrom&cityTo=$cityTo'}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final map = json.decode(response.body);
        return BusRoute.fromJson(map);
      }
    } catch (error) {
      rethrow;
    }
    return null;
  }

  @override
  Future<BusRoute?> getRouteByRouteName(String routeName) {
    // TODO: implement getRouteByRouteName
    throw UnimplementedError();
  }

  @override
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    final url = '$baseUrl${'schedule/$routeName'}';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final mapList = json.decode(res.body) as List;
        return List.generate(
            mapList.length, (index) => BusSchedule.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      return [];
    }
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
