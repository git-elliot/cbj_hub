import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

class LifxWhiteEntity extends GenericLightDE {
  LifxWhiteEntity({
    required CoreUniqueId uniqueId,
    required VendorUniqueId vendorUniqueId,
    required DeviceDefaultName defaultName,
    required DeviceState deviceStateGRPC,
    required DeviceStateMassage stateMassage,
    required DeviceSenderDeviceOs senderDeviceOs,
    required DeviceSenderDeviceModel senderDeviceModel,
    required DeviceSenderId senderId,
    required DeviceCompUuid compUuid,
    required DevicePowerConsumption powerConsumption,
    required GenericLightSwitchState lightSwitchState,
  }) : super(
          uniqueId: uniqueId,
          vendorUniqueId: vendorUniqueId,
          defaultName: defaultName,
          lightSwitchState: lightSwitchState,
          deviceStateGRPC: deviceStateGRPC,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceVendor: DeviceVendor(VendorsAndServices.lifx.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
        );

  LifxPort? lifxPort;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericLightDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    try {
      if (newEntity.lightSwitchState!.getOrCrash() !=
              lightSwitchState!.getOrCrash() ||
          deviceStateGRPC.getOrCrash() != DeviceStateGRPC.ack.toString()) {
        final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
          newEntity.lightSwitchState!.getOrCrash(),
        );

        if (actionToPreform == DeviceActions.on) {
          (await turnOnLight()).fold((l) {
            logger.e('Error turning Lifx light on');
            throw l;
          }, (r) {
            logger.i('Lifx light turn on success');
          });
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold((l) {
            logger.e('Error turning Lifx light off');
            throw l;
          }, (r) {
            logger.i('Lifx light turn off success');
          });
        } else {
          logger.w('actionToPreform is not set correctly on Lifx White');
        }
      }
      deviceStateGRPC = DeviceState(DeviceStateGRPC.ack.toString());
      return right(unit);
    } catch (e) {
      deviceStateGRPC = DeviceState(DeviceStateGRPC.newStateFailed.toString());
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    lightSwitchState = GenericLightSwitchState(DeviceActions.on.toString());
    try {
      final setStateBodyResponse = await LifxConnectorConjector.lifxClient
          ?.setState(vendorUniqueId.getOrCrash(), power: 'on', fast: true);
      if (setStateBodyResponse == null) {
        throw 'setStateBodyResponse is null';
      }

      return right(unit);
    } catch (e) {
      // As we are using the fast = true the response is always
      // LifxHttpException Error
      return right(unit);
      // return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    lightSwitchState = GenericLightSwitchState(DeviceActions.off.toString());

    try {
      final setStateBodyResponse = await LifxConnectorConjector.lifxClient
          ?.setState(vendorUniqueId.getOrCrash(), power: 'off', fast: true);
      if (setStateBodyResponse == null) {
        throw 'setStateBodyResponse is null';
      }
      return right(unit);
    } catch (e) {
      // As we are using the fast = true the response is always
      // LifxHttpException Error
      return right(unit);
      // return left(const CoreFailure.unexpected());
    }
  }
}
