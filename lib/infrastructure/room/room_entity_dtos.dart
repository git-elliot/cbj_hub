import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/room/value_objects_room.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_entity_dtos.freezed.dart';
part 'room_entity_dtos.g.dart';

@freezed
abstract class RoomEntityDtos implements _$RoomEntityDtos {
  factory RoomEntityDtos({
    required String uniqueId,
    required String defaultName,
    required List<String> roomTypes,
    required List<String> roomDevicesId,

    /// Who is using this room
    required List<String> roomMostUsedBy,

    /// Room permissions by users id
    required List<String> roomPermissions,

    // required ServerTimestampConverter() FieldValue serverTimeStamp,
  }) = _RoomEntityDtos;

  RoomEntityDtos._();

  factory RoomEntityDtos.fromDomain(RoomEntity roomEntityDE) {
    return RoomEntityDtos(
      uniqueId: roomEntityDE.uniqueId.getOrCrash(),
      defaultName: roomEntityDE.defaultName.getOrCrash(),
      roomTypes: roomEntityDE.roomTypes.getOrCrash(),
      roomDevicesId: roomEntityDE.roomDevicesId.getOrCrash(),
      roomMostUsedBy: roomEntityDE.roomMostUsedBy.getOrCrash(),
      roomPermissions: roomEntityDE.roomPermissions.getOrCrash(),
    );
  }

  factory RoomEntityDtos.fromJson(Map<String, dynamic> json) =>
      _$RoomEntityDtosFromJson(json);

  RoomEntity toDomain() {
    return RoomEntity(
      uniqueId: RoomUniqueId.fromUniqueString(uniqueId),
      defaultName: RoomDefaultName(defaultName),
      roomTypes: RoomTypes(roomTypes),
      roomDevicesId: RoomDevicesId(roomDevicesId),
      roomMostUsedBy: RoomMostUsedBy(roomMostUsedBy),
      roomPermissions: RoomPermissions(roomPermissions),
    );
  }

  final String deviceDtoClassInstance = (RoomEntityDtos).toString();
}
