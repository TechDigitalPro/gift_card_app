import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gift_card/model/common/qr_model.dart';
import 'package:gift_card/utils/system_utils.dart';
import 'package:gift_card/views/main/qr_scanner_result_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../base_view_model.dart';

class QrScannerViewModel extends BaseViewModel {
  String? mBarcodeStr = '';
  initialize(BuildContext context) async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request().then((value) => {
        
      });
    }
  }

  onClickSave(BuildContext context, String barcodeStr) async {
    if (barcodeStr.isNotEmpty) {
      try{
        var barcode = jsonDecode(barcodeStr);
        QrModel? model = QrModel.fromJson(barcode);

        finishView(context);
        QrScannerResultView(qrModel: model,).launch(context);
      }catch(e){
        debugPrint(e.toString());
        showMessage(StringUtils.txtQRCodeIsNotCorrectFormat, null);
      }
    } else {
      showMessage(StringUtils.txtQRCodeIsNotCorrectFormat, null);
    }
  }
}