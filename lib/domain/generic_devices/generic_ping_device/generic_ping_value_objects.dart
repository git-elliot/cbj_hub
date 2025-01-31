import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_ping_device/generic_ping_validators.dart';
import 'package:dartz/dartz.dart';

class GenericPingSwitchState extends ValueObjectCore<String> {
  factory GenericPingSwitchState(String? input) {
    assert(input != null);
    return GenericPingSwitchState._(
      validateGenericPingStateNotEmty(input!),
    );
  }

  const GenericPingSwitchState._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
