import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gift_card/views/dialog/qr_code_error_dlg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/main/qr_scanner_view_model.dart';


class QrScannerView extends StatefulWidget {
  const QrScannerView({Key? key}) : super(key: key);
 
  @override
  QrScannerViewState createState() => QrScannerViewState();
}

class QrScannerViewState extends State<QrScannerView> {
  BarcodeCapture? result;
  MobileScannerController controller = MobileScannerController(
    returnImage: true,
    detectionTimeoutMs: 1000,
  );
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

Widget _buildQrView(BuildContext context, QrScannerViewModel model) {

    return MobileScanner(
      controller: controller,
      onDetect: (barcode) {
        final Uint8List? image = barcode.image;
        if (barcode.barcodes.isEmpty) {
          debugPrint('Failed to scan QRCode');
        } else {
          result = barcode;
          String? code = barcode.barcodes[0].rawValue;
          if(code == null || !code.toLowerCase().contains(StringUtils.txtAppQR)){
            controller.stop();
            showDialog(
              context: context,
              builder: (BuildContext dlgContext) => QRCodeErrorDlg(
                  title: StringUtils.txtWarning,
                  descriptions: StringUtils.txtQRCodeIsNotCorrectFormat,
                  yesButtonText: StringUtils.txtCancel,
                  noButtonText: StringUtils.txtTryAgain,
                  qrImage: image,
                  onYesClicked: (){
                    finishView(context);
                  },
                  onNoClicked: (){
                    controller.start();
                  },
              )
            );
          }else {
            controller.stop();
            model.onClickSave(context, code);
          }
        }
      });
  }
  

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QrScannerViewModel>.reactive(
      viewModelBuilder: () => QrScannerViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, QrScannerViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: textView(StringUtils.txtScanQRCode,
            textColor: ColorUtils.appColorWhite,
            fontSize: SizeUtils.textSizeNormal,
            fontWeight: FontWeight.bold,
            isCentered: true),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: ColorUtils.appColorWhite,
          onPressed: () => finishView(context),
        ),
        actions: [
           IconButton(
              splashRadius: 25,
              icon: ValueListenableBuilder(
                valueListenable: controller.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off:
                      return Icon(Icons.flash_off, color: ColorUtils.appColorWhite);
                    case TorchState.on:
                      return Icon(Icons.flash_on, color: ColorUtils.appColorWhite);
                  }
                },
              ),
              onPressed: () {
                controller.toggleTorch();
              },
            ),
            IconButton(
              splashRadius: 25,
              icon: ValueListenableBuilder(
                valueListenable: controller.cameraFacingState,
                builder: (context, state, child) {
                  switch (state) {
                    case CameraFacing.front:
                      return const Icon(Icons.cameraswitch_outlined);
                    case CameraFacing.back:
                      return const Icon(Icons.cameraswitch_outlined);
                  }
                },
              ),
              onPressed: () {
                controller.switchCamera();
              },
            ),
        ],
      ),
      body:  Stack(
        children: <Widget>[
          Container(
            child: _buildQrView(context, model),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: RoundButton(
                  isStroked: false,
                  backgroundColor: ColorUtils.appColorBlue,
                  textContent: StringUtils.txtCancel,
                  textSize: SizeUtils.textSizeMedium,
                  isAllCaps: true,
                  radius: 30,
                  onPressed: () {
                    finishView(context);
                  }),
            ),
          )
        ],
      ),
    );
  }
}