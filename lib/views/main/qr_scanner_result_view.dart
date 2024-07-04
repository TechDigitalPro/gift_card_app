import 'package:flutter/material.dart';
import 'package:gift_card/model/common/qr_model.dart';
import 'package:gift_card/utils/size_utils.dart';
import 'package:gift_card/utils/string_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../utils/system_utils.dart';
import '../../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/main/qr_scanner_result_view_model.dart';


// ignore: must_be_immutable
class QrScannerResultView extends StatelessWidget {
  QrScannerResultView({super.key, this.qrModel});

  QrModel? qrModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QrScannerResultViewModel>.reactive(
      viewModelBuilder: () => QrScannerResultViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context, qrModel),
    );
  }

  buildWidget(BuildContext context, QrScannerResultViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          body: Container(
            height: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorUtils.appColorWhite,
                    ColorUtils.appColorWhite,
                    ColorUtils.appColorWhite
                  ],
                )),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: height * 0.05,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            textView(
                              StringUtils.txtWelcome,
                              textColor: ColorUtils.appColorBlack,
                              fontSize: SizeUtils.textSizeNormal
                            ),
                            model.userModel == null
                            ? Container()
                            : textView(
                              '${model.userModel!.firstName} ${model.userModel!.lastName}',
                              textColor: ColorUtils.appColorBlack,
                              fontSize: SizeUtils.textSizeLarge,
                              fontWeight: FontWeight.bold
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorUtils.appColorGreyWhite,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: 
                              (model.userModel == null
                              || model.userModel!.userImage == null 
                              || model.userModel!.userImage!.isEmpty) ?
                              Image.asset(
                                ImageUtils.imgIcLogo,
                                width:  50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                              : CachedNetworkImage(
                                imageUrl: model.userModel!.userImage ?? '',
                                width:  50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Card(
                      color: ColorUtils.appColorGreyWhite,
                      shadowColor: ColorUtils.appColorBlack,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                textView(
                                  '${StringUtils.txtPointBalance}:',
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeMedium
                                ),
                                Expanded(child: Container()),
                                textView(
                                  model.userModel == null
                                  ? ''
                                  : model.userModel!.point.toString(),
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeNormal,
                                  fontWeight: FontWeight.bold
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                textView(
                                  '${StringUtils.txtAccountBalance}:',
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeMedium
                                ),
                                Expanded(child: Container()),
                                textView(
                                  model.userModel == null
                                  ? ''
                                  : StringUtils.txtSymbolUSD + model.userModel!.balance.toString(),
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeNormal,
                                  fontWeight: FontWeight.bold
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                textView(
                                  '${StringUtils.txtAmountDue}:',
                                  textColor: ColorUtils.appColorRed,
                                  fontSize: SizeUtils.textSizeMedium
                                ),
                                Expanded(child: Container()),
                                textView(
                                  StringUtils.txtSymbolUSD + model.qrCodeModel!.amount.toString(),
                                  textColor: ColorUtils.appColorRed,
                                  fontSize: SizeUtils.textSizeNormal,
                                  fontWeight: FontWeight.bold
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              alignment: Alignment.center,
                              child: textView(
                                model.qrCodeModel == null
                                ? ''
                                : model.qrCodeModel!.description.toString(),
                                textColor: ColorUtils.appColorBlack,
                                fontSize: SizeUtils.textSizeNormal,
                                isCentered: true
                              ),
                            ),
                            model.qrCodeModel != null 
                            && model.qrCodeModel!.lat != null &&  model.qrCodeModel!.lat!.isNotEmpty
                            && model.qrCodeModel!.long != null &&  model.qrCodeModel!.long!.isNotEmpty
                            ? Expanded(
                              child: GoogleMap(
                                mapType: MapType.hybrid,
                                compassEnabled: false,
                                mapToolbarEnabled: false,
                                myLocationButtonEnabled: false,
                                zoomControlsEnabled: false,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(double.parse(model.qrCodeModel!.lat!), double.parse(model.qrCodeModel!.long!)),
                                  zoom: 14.4746,
                                ),
                                onMapCreated: (GoogleMapController controller) {
                                  
                                },
                                markers: Set<Marker>.of({
                                  Marker(
                                    markerId: MarkerId(model.qrCodeModel!.lat!),
                                    position: LatLng(double.parse(model.qrCodeModel!.lat!), double.parse(model.qrCodeModel!.long!)),
                                    infoWindow: InfoWindow(title: model.qrCodeModel!.description)
                                  )
                                }),
                              ),
                            )
                            : Container()
                          ],
                        )
                      )
                      
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: RoundButton(
                              isStroked: false,
                              backgroundColor: ColorUtils.appColorBlue,
                              textContent: StringUtils.txtPayNow,
                              textSize: SizeUtils.textSizeMedium,
                              isAllCaps: true,
                              radius: 30,
                              onPressed: () {
                                model.onClickPay(
                                  context,
                                );
                              }),
                        ),
                        const SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            model.onBackClicked(context);
                          },
                          child: Container(
                            width: width,
                            alignment: Alignment.center,
                            color: ColorUtils.appColorTransparent,
                            child: textViewUnderline(
                              StringUtils.txtCancel,
                              fontSize: SizeUtils.textSizeMedium,
                            ),
                          )
                        ),
                        SizedBox(height: height * 0.02,)
                      ],
                    )
                  ],
                ),
              )
            ),
        ),
        onWillPop: () {
          model.onBackClicked(context);
          return Future.value(false);
        });
  }
}