import 'dart:io';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'retrofit.g.dart';

@RestApi(baseUrl: "https://handshake-be.herokuapp.com/api/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/auth/create-account")
  @Headers(<String, dynamic>{
    "content-type": "multipart/form-data",
    "Accept": "application/json"
  })
  Future<String> createAccount(
    @Part() String full_name,
    @Part() String email,
    @Part() String address,
    @Part() String code,
    @Part() String nok_phone_number,
    @Part() String nok_alternate_phone_number,
    @Part() bool is_business,
    @Part() String business_name,
    @Part() String business_address,
    @Part() bool is_vehicle_transport,
    @Part() String vehicle_plate_number,
    @Part() File file, {
    @SendProgress() ProgressCallback? onSendProgress,
  });

  @POST("/user/update-profile")
  @Headers(<String, dynamic>{
    "content-type": "application/x-www-form-urlencoded",
    "Accept": "application/json"
  })
  @FormUrlEncoded()
  Future<String> updateProfile(
    @Header("Authorization") String token,
    @Field() String full_name,
    @Field() String address,
    @Field() String nok_phone_number,
    @Field() String nok_alternate_phone_number,
    @Field() String business_name,
    @Field() String business_address,
    @Field() String vehicle_plate_number,
  );

  @POST("/auth/request-verification-code")
  @Headers(<String, dynamic>{
    "content-type": "application/x-www-form-urlencoded",
    "Accept": "application/json"
  })
  @FormUrlEncoded()
  Future<String> requestVerificationCode(@Field() String phone_number);

  @POST("/auth/verify-otp")
  @Headers(<String, dynamic>{
    "content-type": "application/x-www-form-urlencoded",
    "Accept": "application/json"
  })
  @FormUrlEncoded()
  Future<String> verifyOtpCode(@Field() String phone_number, @Field() String code);

  @POST("/user/raise-alarm")
  @Headers(<String, dynamic>{
    "content-type": "application/x-www-form-urlencoded",
    "Accept": "application/json"
  })
  @FormUrlEncoded()
  Future<String> raiseAlarm(
      @Header("Authorization") String token, @Field() String alarm_type);

  @POST("/user/confirm-connect")
  @Headers(<String, dynamic>{
    "content-type": "application/x-www-form-urlencoded",
    "Accept": "application/json"
  })
  @FormUrlEncoded()
  Future<String> confirmContact(
      @Header("Authorization") String token, @Field() String connect_uid);

  @POST("/user/verify-user-qr")
  @Headers(<String, dynamic>{
    "content-type": "application/x-www-form-urlencoded",
    "Accept": "application/json"
  })
  @FormUrlEncoded()
  Future<String> verifyQrCode(
      @Header("Authorization") String token, @Field() String qr_code);
}
