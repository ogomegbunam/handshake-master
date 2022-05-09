import 'package:json_annotation/json_annotation.dart';

part 'user_model2.g.dart';

@JsonSerializable()
class User2 {
  String id;
  String full_name;
  String avatar;
  String nok_alternate_phone_number;
  String nok_phone_number;
  String email;
  String phone_number;
  String address;
  String? business_name;
  String? business_address;
  String? vehicle_plate_number;
  String? qr_code;
  String current_verification_status;
  String createdAt;
  String updatedAt;

  User2(
      this.id,
      this.full_name,
      this.avatar,
      this.nok_alternate_phone_number,
      this.nok_phone_number,
      this.email,
      this.phone_number,
      this.address,
      this.business_name,
      this.business_address,
      this.vehicle_plate_number,
      this.qr_code,
      this.current_verification_status,
      this.createdAt,
      this.updatedAt);

  factory User2.fromJson(Map<String, dynamic> json) => _$User2FromJson(json);

  Map<String, dynamic> toJson() => _$User2ToJson(this);
}
