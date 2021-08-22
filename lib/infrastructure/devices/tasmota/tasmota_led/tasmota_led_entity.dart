import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:dartz/dartz.dart';

class TasmotaLedEntity extends GenericLightDE {
  TasmotaLedEntity({
    required CoreUniqueId uniqueId,
    required CoreUniqueId roomId,
    required DeviceDefaultName defaultName,
    required DeviceRoomName roomName,
    required DeviceState deviceStateGRPC,
    required DeviceStateMassage stateMassage,
    required DeviceSenderDeviceOs senderDeviceOs,
    required DeviceSenderDeviceModel senderDeviceModel,
    required DeviceSenderId senderId,
    required DeviceCompUuid compUuid,
    required DevicePowerConsumption powerConsumption,
    required GenericLightSwitchState lightSwitchState,
    required this.tasmotaDeviceTopicName,
  }) : super(
          uniqueId: uniqueId,
          defaultName: defaultName,
          roomId: roomId,
          lightSwitchState: lightSwitchState,
          roomName: roomName,
          deviceStateGRPC: deviceStateGRPC,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceVendor: DeviceVendor(VendorsAndServices.tasmota.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
        );

  TasmotaDeviceTopicName tasmotaDeviceTopicName;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction(
      DeviceEntityAbstract newEntity) async {
    if (newEntity is! TasmotaLedEntity) {
      return left(const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type'));
    }

    print('Please override this method in the non generic implementation');
    return left(const CoreFailure.actionExcecuter(
        failedValue: 'Action does not exist'));
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    try {
      getIt<IMqttServerRepository>().publishMessage(
          'cmnd/${tasmotaDeviceTopicName.getOrCrash()}/Power', 'ON');
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    try {
      getIt<IMqttServerRepository>().publishMessage(
          'cmnd/${tasmotaDeviceTopicName.getOrCrash()}/Power', 'OFF');
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
