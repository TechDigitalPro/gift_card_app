import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';

// ignore: must_be_immutable
class QRCodeErrorDlg extends StatefulWidget {
  QRCodeErrorDlg(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.yesButtonText,
      required this.noButtonText,
      this.qrImage,
      this.onYesClicked,
      this.onNoClicked,})
      : super(key: key);
  final String title, descriptions, yesButtonText, noButtonText;
  Function? onYesClicked, onNoClicked;
  Uint8List? qrImage;

  @override
  State<QRCodeErrorDlg> createState() => _QRCodeErrorDlgState();
}

class _QRCodeErrorDlgState extends State<QRCodeErrorDlg> {
  
  @override
  Widget build(BuildContext context) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      backgroundColor: ColorUtils.appColorTransparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, width * 0.1, 0, 0),
          padding: EdgeInsets.fromLTRB(20, width * 0.15, 20, 20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: ColorUtils.appColorWhite,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: ColorUtils.appColorBlack_50,
                    offset: const Offset(0, 10),
                    blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              textView(widget.title,
                  textColor: ColorUtils.appColorTextDark,
                  fontSize: SizeUtils.textSizeXLarge,
                  fontWeight: FontWeight.bold,
                  isCentered: true,
                  textAllCaps: true,
                  maxLine: 4),
              Container(
                padding: const EdgeInsets.all(10),
                child: 
                widget.qrImage != null 
                ? Image(
                    image: MemoryImage(widget.qrImage!),
                    width: width * 0.5,
                    height: width * 0.5,
                  )
                : Container()
              ),
              textView(widget.descriptions,
                  textColor: ColorUtils.appColorTextLight,
                  fontSize: SizeUtils.textSizeSMedium,
                  fontWeight: FontWeight.w400,
                  isCentered: true,
                  maxLine: 5),
              const SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RoundButton(
                    isStroked: false,
                    backgroundColor: ColorUtils.appColorBlue,
                    textContent: widget.noButtonText,
                    textSize: SizeUtils.textSizeMedium,
                    radius: 30,
                    onPressed: () {
                      finishView(context);
                      if(widget.onNoClicked != null){
                        widget.onNoClicked!();
                      }
                    }),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      finishView(context);
                      if(widget.onYesClicked != null){
                        widget.onYesClicked!();
                      }
                    },
                    child: Container(
                      width: width,
                      alignment: Alignment.center,
                      color: ColorUtils.appColorTransparent,
                      child: textViewUnderline(
                        widget.yesButtonText,
                        fontSize: SizeUtils.textSizeMedium,
                      ),
                    )
                  )
                ],
              ),
            ],
          ),
        ),
        Image.asset(
          ImageUtils.imgIcLogoRound,
          width: width * 0.2,
          height: width * 0.2,
          fit: BoxFit.cover,
        )
      ],
    );
  }
}
