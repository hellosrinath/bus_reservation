// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusReservationImpl _$$BusReservationImplFromJson(Map<String, dynamic> json) =>
    _$BusReservationImpl(
      reservationId: json['reservationId'] as int?,
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
      busSchedule:
          BusSchedule.fromJson(json['busSchedule'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as int,
      departureDate: json['departureDate'] as String,
      totalSeatBooked: json['totalSeatBooked'] as int,
      seatNumbers: json['seatNumbers'] as String,
      reservationStatus: json['reservationStatus'] as String,
      totalPrice: json['totalPrice'] as int,
    );

Map<String, dynamic> _$$BusReservationImplToJson(
        _$BusReservationImpl instance) =>
    <String, dynamic>{
      'reservationId': instance.reservationId,
      'customer': instance.customer,
      'busSchedule': instance.busSchedule,
      'timestamp': instance.timestamp,
      'departureDate': instance.departureDate,
      'totalSeatBooked': instance.totalSeatBooked,
      'seatNumbers': instance.seatNumbers,
      'reservationStatus': instance.reservationStatus,
      'totalPrice': instance.totalPrice,
    };
