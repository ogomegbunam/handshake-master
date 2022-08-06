// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://handshake-be.herokuapp.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<String> createAccount(
      fullName,
      email,
      address,
      code,
      nokPhoneNumber,
      nokAlternatePhoneNumber,
      isBusiness,
      businessName,
      businessAddress,
      isVehicleTransport,
      vehiclePlateNumber,
      file,
      {onSendProgress}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'content-type': 'multipart/form-data',
      r'Accept': 'application/json'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.fields.add(MapEntry('full_name', fullName));
    _data.fields.add(MapEntry('email', email));
    _data.fields.add(MapEntry('address', address));
    _data.fields.add(MapEntry('code', code));
    _data.fields.add(MapEntry('nok_phone_number', nokPhoneNumber));
    _data.fields.add(
        MapEntry('nok_alternate_phone_number', nokAlternatePhoneNumber));
    _data.fields.add(MapEntry('is_business', isBusiness.toString()));
    _data.fields.add(MapEntry('business_name', businessName));
    _data.fields.add(MapEntry('business_address', businessAddress));
    _data.fields
        .add(MapEntry('is_vehicle_transport', isVehicleTransport.toString()));
    _data.fields.add(MapEntry('vehicle_plate_number', vehiclePlateNumber));
    _data.files.add(MapEntry(
        'file',
        MultipartFile.fromFileSync(file.path,
            filename: file.path.split(Platform.pathSeparator).last)));
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data')
        .compose(_dio.options, '/auth/create-account',
            queryParameters: queryParameters,
            data: _data,
            onSendProgress: onSendProgress)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> updateProfile(
      token,
      fullName,
      address,
      nokPhoneNumber,
      nokAlternatePhoneNumber,
      businessName,
      businessAddress,
      vehiclePlateNumber) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'content-type': 'application/x-www-form-urlencoded',
      r'Accept': 'application/json',
      r'Authorization': token
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'full_name': fullName,
      'address': address,
      'nok_phone_number': nokPhoneNumber,
      'nok_alternate_phone_number': nokAlternatePhoneNumber,
      'business_name': businessName,
      'business_address': businessAddress,
      'vehicle_plate_number': vehiclePlateNumber
    };
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, '/user/update-profile',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> requestVerificationCode(phoneNumber) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'content-type': 'application/x-www-form-urlencoded',
      r'Accept': 'application/json'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'phone_number': phoneNumber};
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, '/auth/request-verification-code',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> verifyOtpCode(phoneNumber, code) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'content-type': 'application/x-www-form-urlencoded',
      r'Accept': 'application/json'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'phone_number': phoneNumber, 'code': code};
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, '/auth/verify-otp',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> raiseAlarm(token, alarmType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'content-type': 'application/x-www-form-urlencoded',
      r'Accept': 'application/json',
      r'Authorization': token
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'alarm_type': alarmType};
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, '/user/raise-alarm',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> confirmContact(token, connectUid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'content-type': 'application/x-www-form-urlencoded',
      r'Accept': 'application/json',
      r'Authorization': token
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'connect_uid': connectUid};
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, '/user/confirm-connect',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> verifyQrCode(token, qrCode) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'content-type': 'application/x-www-form-urlencoded',
      r'Accept': 'application/json',
      r'Authorization': token
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'qr_code': qrCode};
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, '/user/verify-user-qr',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
