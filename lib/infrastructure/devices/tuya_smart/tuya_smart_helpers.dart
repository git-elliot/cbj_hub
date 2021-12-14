import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_jbt_a70_rgbcw_wf/tuya_smart_jbt_a70_rgbcw_wf_entity.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/cloudtuya.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/tuya_device_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/tuya_light.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/tuya_switch.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_switch/tuya_smart_switch_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';

class TuyaSmartHelpers {
  static DeviceEntityAbstract addDiscoverdDevice({
    required TuyaDeviceAbstract tuyaSmartDevice,
    required CloudTuya cloudTuyaOrSmartLifeOrJinvooSmart,
  }) {
    DeviceEntityAbstract tuyaSmartDE;

    if (tuyaSmartDevice is TuyaLight) {
      tuyaSmartDE = TuyaSmartJbtA70RgbcwWfEntity(
        uniqueId: CoreUniqueId(),
        vendorUniqueId: VendorUniqueId.fromUniqueString(tuyaSmartDevice.id),
        defaultName: DeviceDefaultName(
          tuyaSmartDevice.name != ''
              ? tuyaSmartDevice.name
              : 'TuyaSmart test 2',
        ),
        deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
        senderDeviceOs: DeviceSenderDeviceOs('tuya_smart'),
        senderDeviceModel: DeviceSenderDeviceModel('1SE'),
        senderId: DeviceSenderId(),
        compUuid: DeviceCompUuid('34asdfrsd23gggg'),
        stateMassage: DeviceStateMassage('Hello World'),
        powerConsumption: DevicePowerConsumption('0'),
        lightSwitchState:
            GenericRgbwLightSwitchState(tuyaSmartDevice.state.toString()),
        lightColorTemperature: GenericRgbwLightColorTemperature(
          tuyaSmartDevice.colorTemp.toString(),
        ),
        lightBrightness:
            GenericRgbwLightBrightness(tuyaSmartDevice.brightness.toString()),
        lightColorAlpha: GenericRgbwLightColorAlpha('1.0'),
        lightColorHue: GenericRgbwLightColorHue('0.0'),
        lightColorSaturation: GenericRgbwLightColorSaturation('1.0'),
        lightColorValue: GenericRgbwLightColorValue('1.0'),
        cloudTuya: cloudTuyaOrSmartLifeOrJinvooSmart,
      );
    } else if (tuyaSmartDevice is TuyaSwitch) {
      tuyaSmartDE = TuyaSmartSwitchEntity(
        uniqueId: CoreUniqueId(),
        vendorUniqueId: VendorUniqueId.fromUniqueString(tuyaSmartDevice.id),
        defaultName: DeviceDefaultName(
          tuyaSmartDevice.name != ''
              ? tuyaSmartDevice.name
              : 'TuyaSmart test 2',
        ),
        deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
        senderDeviceOs: DeviceSenderDeviceOs('tuya_smart'),
        senderDeviceModel: DeviceSenderDeviceModel('Cloud'),
        senderId: DeviceSenderId(),
        compUuid: DeviceCompUuid('34asdfrsd23gggg'),
        stateMassage: DeviceStateMassage('Hello World'),
        powerConsumption: DevicePowerConsumption('0'),
        switchState: GenericLightSwitchState(tuyaSmartDevice.state.toString()),
        cloudTuya: cloudTuyaOrSmartLifeOrJinvooSmart,
      );
    } else {
      logger.e('Tuya type does not exist');
      throw 'Error Tuya type does not exist ${tuyaSmartDevice.haType}';
    }
    return tuyaSmartDE;
  }
}
