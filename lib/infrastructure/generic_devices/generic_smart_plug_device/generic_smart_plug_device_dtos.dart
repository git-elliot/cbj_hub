import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_plug_device/generic_switch_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_plug_device/generic_switch_value_objects.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_smart_plug_device_dtos.freezed.dart';
part 'generic_smart_plug_device_dtos.g.dart';

@freezed
abstract class GenericSmartPlugDeviceDtos
    implements _$GenericSmartPlugDeviceDtos, DeviceEntityDtoAbstract {
  factory GenericSmartPlugDeviceDtos({
    // @JsonKey(ignore: true)
    String? deviceDtoClass,
    required String id,
    required String vendorUniqueId,
    required String? defaultName,
    required String? deviceStateGRPC,
    String? stateMassage,
    required String? senderDeviceOs,
    required String? senderDeviceModel,
    required String? senderId,
    required String? smartPlugState,
    required String? deviceTypes,
    required String? compUuid,
    required String? deviceVendor

    // required ServerTimestampConverter() FieldValue serverTimeStamp,
    ,
  }) = _GenericSmartPlugDeviceDtos;

  GenericSmartPlugDeviceDtos._();

  factory GenericSmartPlugDeviceDtos.fromDomain(
    GenericSmartPlugDE genericSmartPlugDe,
  ) {
    return GenericSmartPlugDeviceDtos(
      deviceDtoClass: (GenericSmartPlugDeviceDtos).toString(),
      id: genericSmartPlugDe.uniqueId.getOrCrash(),
      vendorUniqueId: genericSmartPlugDe.vendorUniqueId.getOrCrash(),
      defaultName: genericSmartPlugDe.defaultName.getOrCrash(),
      deviceStateGRPC: genericSmartPlugDe.deviceStateGRPC.getOrCrash(),
      stateMassage: genericSmartPlugDe.stateMassage.getOrCrash(),
      senderDeviceOs: genericSmartPlugDe.senderDeviceOs.getOrCrash(),
      senderDeviceModel: genericSmartPlugDe.senderDeviceModel.getOrCrash(),
      senderId: genericSmartPlugDe.senderId.getOrCrash(),
      smartPlugState: genericSmartPlugDe.smartPlugState!.getOrCrash(),
      deviceTypes: genericSmartPlugDe.deviceTypes.getOrCrash(),
      compUuid: genericSmartPlugDe.compUuid.getOrCrash(),
      deviceVendor: genericSmartPlugDe.deviceVendor.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory GenericSmartPlugDeviceDtos.fromJson(Map<String, dynamic> json) =>
      _$GenericSmartPlugDeviceDtosFromJson(json);

  @override
  final String deviceDtoClassInstance = (GenericSmartPlugDeviceDtos).toString();

  @override
  DeviceEntityAbstract toDomain() {
    return GenericSmartPlugDE(
      uniqueId: CoreUniqueId.fromUniqueString(id),
      vendorUniqueId: VendorUniqueId.fromUniqueString(vendorUniqueId),
      defaultName: DeviceDefaultName(defaultName),
      deviceStateGRPC: DeviceState(deviceStateGRPC),
      stateMassage: DeviceStateMassage(stateMassage),
      senderDeviceOs: DeviceSenderDeviceOs(senderDeviceOs),
      senderDeviceModel: DeviceSenderDeviceModel(senderDeviceModel),
      senderId: DeviceSenderId.fromUniqueString(senderId),
      deviceVendor: DeviceVendor(deviceVendor),
      compUuid: DeviceCompUuid(compUuid),
      smartPlugState: GenericSmartPlugState(smartPlugState),
    );
  }
}
