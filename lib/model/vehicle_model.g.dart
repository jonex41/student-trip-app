// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VehicleModel _$$_VehicleModelFromJson(Map<String, dynamic> json) =>
    _$_VehicleModel(
      uId: json['uId'] as String?,
      id: json['id'] as String?,
      ownderId: json['ownderId'] as String?,
      name: json['name'] as String?,
      model: json['model'] as String?,
      type: json['type'] as String?,
      plateNumber: json['plateNumber'] as String?,
      count: json['count'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      capacity: json['capacity'] as String?,
      address: json['address'] as String?,
      date: json['date'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$_VehicleModelToJson(_$_VehicleModel instance) =>
    <String, dynamic>{
      'uId': instance.uId,
      'id': instance.id,
      'ownderId': instance.ownderId,
      'name': instance.name,
      'model': instance.model,
      'type': instance.type,
      'plateNumber': instance.plateNumber,
      'count': instance.count,
      'phoneNumber': instance.phoneNumber,
      'capacity': instance.capacity,
      'address': instance.address,
      'date': instance.date,
      'imageUrl': instance.imageUrl,
    };
