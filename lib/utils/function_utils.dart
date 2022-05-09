
import 'package:flutter/material.dart';
import 'package:handshake/widgets/progress_dialog.dart';
class FunctionUtils {

  static void showSnackBar(BuildContext context,String msg){
    final SnackBar snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static ProgressDialog prepareLoadingDialog(BuildContext context) {
    var dialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(
      progressWidget: const Padding(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(),
      ),
    );
    dialog.update(message: 'Please wait...');
    return dialog;
  }

  static ProgressDialog prepareUploadDialog(BuildContext context) {
    var dialog = ProgressDialog(context,
        type: ProgressDialogType.Download, isDismissible: false);
    dialog.style(
      progressWidget: const Padding(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(),
      ),
    );
    dialog.update(message:'Uploading...', progress: 0, maxProgress: 100);
    return dialog;
  }

}