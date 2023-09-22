import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';
import 'package:images_picker/images_picker.dart';

enum ImageTypeEnum { gallery, camera }

class ImagePickerWidget extends StatelessWidget {
  final Function onSelectedImage;
  final Function onClear;
  final String currentImage;
  final String title;
  final Color? color;
  final bool isRequired;
  final bool isLoading;

  const ImagePickerWidget({
    Key? key,
    required this.onSelectedImage,
    required this.currentImage,
    required this.onClear,
    required this.title,
    required this.isLoading,
    this.color,
    this.isRequired = false,
  }) : super(key: key);

  Future<ImageTypeEnum?> showModelSheetFunction(BuildContext context) async {
    return await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        enableDrag: true,
        backgroundColor: white,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), topLeft: Radius.circular(8)),
        ),
        builder: (BuildContext context) {
          return Container(
              margin: EdgeInsets.all(12 * SizeConfig.heightMultiplier!),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(ImageTypeEnum.camera);
                      },
                      child: const Text('Camera')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(ImageTypeEnum.gallery);
                      },
                      child: const Text('Gallery')),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Text(
            title,
            style: AppTextStyle.content.copyWith(
                fontSize: 16 * SizeConfig.textMultiplier!,
                fontWeight: FontWeight.w400,
                color: grey128,
                height: 1.5),
          ),
          isRequired
              ? Text(
                  ' *',
                  style: AppTextStyle.content.copyWith(
                      fontSize: 14 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w400,
                      color: red212,
                      height: 1.5),
                )
              : const SizedBox(),
        ],
      ),
      SizedBox(height: 8 * SizeConfig.heightMultiplier!),
      GestureDetector(
          onTap: () async {
            var imageType = await showModelSheetFunction(context);
            if (imageType == null) return;
            dynamic media;
            if (imageType == ImageTypeEnum.camera) {
              media = await ImagesPicker.openCamera(
                pickType: PickType.image,
                quality: 0.6,
              );
            } else {
              media = await ImagesPicker.pick(
                  pickType: PickType.image, quality: 0.6);
            }
            if (media != null) {
              onSelectedImage(media[0].path);
            }
          },
          child: Container(
              height: 48 * SizeConfig.heightMultiplier!,
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: 16 * SizeConfig.widthMultiplier!,
                  vertical: 12 * SizeConfig.heightMultiplier!),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: color ?? white238, width: 1)),
              child: Row(
                children: [
                  currentImage.isEmpty
                      ? Icon(Icons.upload_outlined)
                      : isLoading
                          ? SizedBox(
                              height: 20 * SizeConfig.heightMultiplier!,
                              width: 20 * SizeConfig.widthMultiplier!,
                              child: CircularProgressIndicator(
                                strokeWidth: 3 * SizeConfig.widthMultiplier!,
                              ))
                          : const Icon(
                              Icons.image,
                              color: blue77,
                            ),
                  SizedBox(width: 16 * SizeConfig.widthMultiplier!),
                  currentImage.isEmpty
                      ? Text('Add File',
                          style: AppTextStyle.content.copyWith(
                            fontSize: 16 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w500,
                            color: blue97,
                          ))
                      : Flexible(
                          child: Text(currentImage.split('/').last,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.content.copyWith(
                                fontSize: 16 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w400,
                                color: black3E,
                              )),
                        ),
                  SizedBox(width: 16 * SizeConfig.widthMultiplier!),
                  currentImage.isEmpty
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () => onClear(),
                          child: Icon(Icons.clear),
                        )
                ],
              ))),
    ]);
  }
}
