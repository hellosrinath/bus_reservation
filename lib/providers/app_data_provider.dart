import 'package:flutter/material.dart';

import '../datasource/app_data_source.dart';
import '../datasource/data_source.dart';
import '../models/app_user.dart';
import '../models/auth_response_model.dart';
import '../models/bus_model.dart';
import '../models/bus_reservation.dart';
import '../models/bus_schedule.dart';
import '../models/bus_route.dart';
import '../models/reservation_expansion_item.dart';
import '../models/response_model.dart';
import '../utils/helper_functions.dart';

class AppDataProvider extends ChangeNotifier {
  List<Bus> _busList = [];
  List<BusRoute> _routeList = [];
  List<BusReservation> _reservationList = [];
  List<BusSchedule> _scheduleList = [];

  List<Bus> get busList => _busList;

  List<BusRoute> get routeList => _routeList;

  List<BusReservation> get reservationList => _reservationList = [];

  List<BusSchedule> get scheduleList => _scheduleList = [];

  // final DataSource _dataSource = DummyDataSource();
  final DataSource _dataSource = AppDataSource();

  Future<AuthResponseModel?> login(AppUser user) async {
    final response = await _dataSource.login(user);
    if (response == null) return null;
    await saveToken(response.accessToken);
    await saveLoginTime(response.loginTime);
    await saveExpirationDuration(response.expirationDuration);
    return response;
  }

  Future<ResponseModel> addBus(Bus bus) {
    return _dataSource.addBus(bus);
  }

  Future<ResponseModel> addRoute(BusRoute busRoute) {
    return _dataSource.addRoute(busRoute);
  }

  Future<ResponseModel> addSchedule(BusSchedule busSchedule) {
    return _dataSource.addSchedule(busSchedule);
  }

  void getAllBus() async {
    _busList = await _dataSource.getAllBus();
    notifyListeners();
  }

  void getAllRoute() async {
    _routeList = await _dataSource.getAllRoutes();
    notifyListeners();
  }

  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) {
    return _dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }

  Future<List<BusReservation>> getAllReservations() async {
    _reservationList = await _dataSource.getAllReservation();
    notifyListeners();
    return _reservationList;
  }

  Future<List<BusReservation>> getReservationByMobile(String mobile) {
    return _dataSource.getReservationsByMobile(mobile);
  }

  Future<List<BusSchedule>> getScheduleByRouteName(String routeName) async {
    return _dataSource.getSchedulesByRouteName(routeName);
  }

  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) async {
    return _dataSource.getReservationsByScheduleAndDepartureDate(
        scheduleId, departureDate);
  }

  Future<ResponseModel> addReservation(BusReservation reservation) {
    return _dataSource.addReservation(reservation);
  }

  List<ReservationExpansionItem> getExpansionItem(
      List<BusReservation> reservationList) {
    return List.generate(
      reservationList.length,
      (index) {
        final reservation = reservationList[index];
        return ReservationExpansionItem(
          header: ReservationExpansionHeader(
            reservationId: reservation.reservationId,
            departureDate: reservation.departureDate,
            schedule: reservation.busSchedule,
            timestamp: reservation.timestamp,
            reservationStatus: reservation.reservationStatus,
          ),
          body: ReservationExpansionBody(
            customer: reservation.customer,
            totalSeatBooked: reservation.totalSeatBooked,
            seatNumbers: reservation.seatNumbers,
            totalPrice: reservation.totalPrice,
          ),
        );
      },
    );
  }
}
