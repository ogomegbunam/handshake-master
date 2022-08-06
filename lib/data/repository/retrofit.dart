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
    @Part() String fullName,
    @Part() String email,
    @Part() String address,
    @Part() String code,
    @Part() String nokPhoneNumber,
    @Part() String nokAlternatePhoneNumber,
    @Part() bool isBusiness,
    @Part() String businessName,
    @Part() String businessAddress,
    @Part() bool isVehicleTransport,
    @Part() String vehiclePlateNumber,
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
    @Field() String fullName,
    @Field() String address,
    @Field() String nokPhoneNumber,
    @Field() String nokAlternatePhoneNumber,
    @Field() String businessName,
    @Field() String businessAddress,
    @Field() String vehiclePlateNumber,
  );

  @POST("/auth/request-verification-code")
  @Headers(<String, dynamic>{
    "content-type": "application/x-www-form-urlencoded",
    "Accept": "application/json"
  })
  @FormUrlEncoded()
  Future<String> requestVerificationCode(@Field() String phoneNumber);

  @POST("/auth/verify-otp")
  @Headers(<String, dynamic>{
    "content-type": "application/x-www-form-urlencoded",
    "Accept": "application/json"
  })
  @FormUrlEncoded()
  Future<String> verifyOtpCode(@Field() String phoneNumber, @Field() String code);

  @POST("/user/raise-alarm")
  @Headers(<String, dynamic>{
    "content-type": "application/x-www-form-urlencoded",
    "Accept": "application/json"
  })
  @FormUrlEncoded()
  Future<String> raiseAlarm(
      @Header("Authorization") String token, @Field() String alarmType);

  @POST("/user/confirm-connect")
  @Headers(<String, dynamic>{
    "content-type": "application/x-www-form-urlencoded",
    "Accept": "application/json"
  })
  @FormUrlEncoded()
  Future<String> confirmContact(
      @Header("Authorization") String token, @Field() String connectUid);

  @POST("/user/verify-user-qr")
  @Headers(<String, dynamic>{
    "content-type": "application/x-www-form-urlencoded",
    "Accept": "application/json"
  })
  @FormUrlEncoded()
  Future<String> verifyQrCode(
      @Header("Authorization") String token, @Field() String qrCode);
}
