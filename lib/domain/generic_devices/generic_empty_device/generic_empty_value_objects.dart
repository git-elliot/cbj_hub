import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_empty_device/generic_empty_validators.dart';
import 'package:dartz/dartz.dart';

class GenericEmptySwitchState extends ValueObjectCore<String> {
  factory GenericEmptySwitchState(String? input) {
    assert(input != null);
    return GenericEmptySwitchState._(
      validateGenericEmptyStateNotEmty(input!),
    );
  }

  const GenericEmptySwitchState._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
