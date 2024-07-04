import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gift_card/model/common/user_model.dart';
import 'package:gift_card/model/request/purchase_req.dart';
import 'package:gift_card/model/request/register_req.dart';
import 'package:gift_card/model/response/purchase_res.dart';

import '../model/request/login_req.dart';
import '../model/response/login_res.dart';
import '../utils/api_utils.dart';

class NetworkService {
  var dio = Dio(); 

  Future doPostRequest(String url, {dynamic param, dynamic body, dynamic token}) async {
    try {
      var formData = FormData();
      if(body != null){
        formData = FormData.fromMap(body);
      }
      if(token != null) {
        dio.options.headers["authorization"] = "Bearer $token";
      }

      Response response = await dio.post(
        url,
        queryParameters: param,
        data: body == null ? '' : formData,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      var resData = response.data;
      return resData;

    } catch (e) {
      debugPrint(e.toString());
      if (e is DioError) {
        return e.response?.data;
      }else {
        return null;
      }
    }
  }

  Future doGetRequest(String url, {dynamic param, dynamic token}) async {
    try {
      if(token != null) {
        dio.options.headers["authorization"] = "Bearer $token";
      }
      Response response = await dio.get(
        url,
        queryParameters: param,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      var resData = response.data;
      return resData;

    } catch (e) {
      debugPrint(e.toString());
      if (e is DioError) {
        return e.response?.data;
      }else {
        return null;
      }
    }
  }

  // Auth
  Future<LoginRes?> doLogin(LoginReq req) async {
    var res = await doPostRequest(ApiUtils.urlLogin, body: req.toJson());
    LoginRes? response;
    try{
      var responseMap = jsonDecode(res);
      bool status = responseMap['status'];
      if(status){
        response = LoginRes(
          status: status,
          apiVersion: responseMap['api_version'],
          token: responseMap['data']['token'],
          user: UserModel.fromJson(responseMap['data']['user_info']),
        );
      }else {
        response = LoginRes(
          status: status,
          apiVersion: responseMap['api_version'],
          message: responseMap['message'],
        );
      }
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }

  Future<LoginRes?> doRegister(RegisterReq req) async {
    var res = await doPostRequest(ApiUtils.urlRegister, body: req.toJson());
    LoginRes? response;
    try{
      var responseMap = jsonDecode(res);
      bool status = responseMap['status'];
      if(status){
        response = LoginRes(
          status: status,
          apiVersion: responseMap['api_version'],
          token: responseMap['data']['token'],
          user: UserModel.fromJson(responseMap['data']['user_info']),
        );
      }else {
        response = LoginRes(
          status: status,
          apiVersion: responseMap['api_version'],
          message: responseMap['message'],
        );
      }
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }

  Future<PurchaseRes?> doPurchaseGift(PurchaseReq req) async {
    var res = await doPostRequest(ApiUtils.urlPurchaseGift, body: req.toJson());
    PurchaseRes? response;
    try{
      var responseMap = jsonDecode(res);
      bool status = responseMap['status'];
      if(status){
        response = PurchaseRes(
          status: status,
          apiVersion: responseMap['api_version'],
          user: UserModel.fromJson(responseMap['data']),
        );
      }else {
        response = PurchaseRes(
          status: status,
          apiVersion: responseMap['api_version'],
          message: responseMap['message'],
        );
      }
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }
}
