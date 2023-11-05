import 'package:bus_reservation_udemy/datasource/data_source.dart';
import 'package:bus_reservation_udemy/datasource/temp_db.dart';
import 'package:bus_reservation_udemy/models/app_user.dart';
import 'package:bus_reservation_udemy/models/auth_response_model.dart';
import 'package:bus_reservation_udemy/models/bus_model.dart';
import 'package:bus_reservation_udemy/models/bus_reservation.dart';
import 'package:bus_reservation_udemy/models/bus_schedule.dart';
import 'package:bus_reservation_udemy/models/but_route.dart';
import 'package:bus_reservation_udemy/models/response_model.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:flutter/material.dart';

class DummyDataSource extends DataSource {
  @override
  Future<ResponseModel> addBus(Bus bus) async {
    TempDB.tableBus.add(bus);
    return ResponseModel(
      responseStatus: ResponseStatus.SAVED,
      statusCode: 200,
      message: 'Saved Bus',
      object: {},
    );
  }

  @override
  Future<ResponseModel> addReservation(BusReservation reservation) async {
    TempDB.tableReservation.add(reservation);
    debugPrint('Reservation Length: ${TempDB.tableReservation.length}');
    return ResponseModel(
      responseStatus: ResponseStatus.SAVED,
      statusCode: 200,
      message: 'Your seat has been booked',
      object: {},
    );
  }

  @override
  Future<ResponseModel> addRoute(BusRoute busRoute) async {
    TempDB.tableRoute.add(busRoute);
    return ResponseModel(
      responseStatus: ResponseStatus.SAVED,
      statusCode: 200,
      message: 'Saved Route',
      object: {},
    );
  }

  @override
  Future<ResponseModel> addSchedule(BusSchedule busSchedule) async {
    TempDB.tableSchedule.add(busSchedule);
    return ResponseModel(
      responseStatus: ResponseStatus.SAVED,
      statusCode: 200,
      message: 'Saved Scheduled',
      object: {},
    );
  }

  @override
  Future<List<Bus>> getAllBus() async {
    return TempDB.tableBus;
  }

  @override
  Future<List<BusReservation>> getAllReservation() async {
    return TempDB.tableReservation;
  }

  @override
  Future<List<BusRoute>> getAllRoutes() async {
    return TempDB.tableRoute;
  }

  @override
  Future<List<BusSchedule>> getAllSchedules() {
    // TODO: implement getAllSchedules
    throw UnimplementedError();
  }

  @override
  Future<List<BusReservation>> getReservationsByMobile(String mobile) async {
    return TempDB.tableReservation
        .where((reservation) => reservation.customer.mobile == mobile)
        .toList();
  }

  @override
  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) async {
    return TempDB.tableReservation
        .where((busReservation) =>
            busReservation.busSchedule.scheduleId == scheduleId &&
            busReservation.departureDate == departureDate)
        .toList();
  }

  @override
  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) async {
    BusRoute? busRoute;
    try {
      busRoute = TempDB.tableRoute.firstWhere(
        (element) => element.cityFrom == cityFrom && element.cityTo == cityTo,
      );
      return busRoute;
    } on StateError catch (e) {
      debugPrint(e.message.toString());
      return null;
    }
  }

  @override
  Future<BusRoute?> getRouteByRouteName(String routeName) {
    // TODO: implement getRouteByRouteName
    throw UnimplementedError();
  }

  @override
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    return TempDB.tableSchedule
        .where((schedule) => schedule.busRoute.routeName == routeName)
        .toList();
  }

  @override
  Future<AuthResponseModel?> login(AppUser user) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
