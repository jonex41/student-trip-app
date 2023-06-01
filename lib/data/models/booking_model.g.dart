// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookingModel _$$_BookingModelFromJson(Map<String, dynamic> json) =>
    _$_BookingModel(
      source: json['source'] as String?,
      destination: json['destination'] as String?,
      departureDate: json['departureDate'] as String?,
      departureTime: json['departureTime'] as String?,
      bookinRef: json['bookinRef'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      progress: json['progress'] as String?,
      latS: (json['latS'] as num?)?.toDouble(),
      longS: (json['longS'] as num?)?.toDouble(),
      latD: (json['latD'] as num?)?.toDouble(),
      longD: (json['longD'] as num?)?.toDouble(),
      driverName: json['driverName'] as String?,
      driverId: json['driverId'] as String?,
      driverStaffId: json['driverStaffId'] as String?,
      studentName: json['studentName'] as String?,
      noPassenger: json['noPassenger'] as int?,
    );

Map<String, dynamic> _$$_BookingModelToJson(_$_BookingModel instance) =>
    <String, dynamic>{
      'source': instance.source,
      'destination': instance.destination,
      'departureDate': instance.departureDate,
      'departureTime': instance.departureTime,
      'bookinRef': instance.bookinRef,
      'date': instance.date,
      'time': instance.time,
      'progress': instance.progress,
      'latS': instance.latS,
      'longS': instance.longS,
      'latD': instance.latD,
      'longD': instance.longD,
      'driverName': instance.driverName,
      'driverId': instance.driverId,
      'driverStaffId': instance.driverStaffId,
      'studentName': instance.studentName,
      'noPassenger': instance.noPassenger,
    };
