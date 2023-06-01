// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_operation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VehicleOperationModel _$$_VehicleOperationModelFromJson(
        Map<String, dynamic> json) =>
    _$_VehicleOperationModel(
      trip_in_progress: json['trip_in_progress'] as String?,
      vehicle_in_queue: json['vehicle_in_queue'] as String?,
      completed_trips: json['completed_trips'] as String?,
      cummuter_statistics: json['cummuter_statistics'] as String?,
      destination: json['destination'] as String?,
      daily_no_trip: json['daily_no_trip'] as String?,
      time: json['time'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$$_VehicleOperationModelToJson(
        _$_VehicleOperationModel instance) =>
    <String, dynamic>{
      'trip_in_progress': instance.trip_in_progress,
      'vehicle_in_queue': instance.vehicle_in_queue,
      'completed_trips': instance.completed_trips,
      'cummuter_statistics': instance.cummuter_statistics,
      'destination': instance.destination,
      'daily_no_trip': instance.daily_no_trip,
      'time': instance.time,
      'date': instance.date,
    };
