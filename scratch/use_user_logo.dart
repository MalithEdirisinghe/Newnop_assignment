import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  final userLogoFile = File(r'C:\Mywork\Works\Newnop Assignment\assets\icon\logo.png');
  final bytes = userLogoFile.readAsBytesSync();
  final original = img.decodeImage(bytes);

  if (original != null) {
    print('Original dimensions: ${original.width}x${original.height}');
    
    // Resize user logo to 700x700 for Android 12+ safe circular splash margin
    final resizedLogo = img.copyResize(original, width: 700, height: 700);

    // Create a 1024x1024 canvas with dark slate blue background #0F172A
    final canvas = img.Image(width: 1024, height: 1024);
    img.fill(canvas, color: img.ColorRgba8(15, 23, 42, 255));

    // Composite centered user logo onto canvas (x=162, y=162)
    img.compositeImage(canvas, resizedLogo, dstX: 162, dstY: 162);

    final pngBytes = img.encodePng(canvas);

    File(r'C:\Mywork\Works\Newnop Assignment\android\app\src\main\res\drawable\splash_logo.png')
        .writeAsBytesSync(pngBytes);

    print('Successfully updated splash_logo.png from assets/icon/logo.png!');
  }
}
