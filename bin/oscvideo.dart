import 'package:mpv_dart/mpv_dart.dart';

void main() async {
  MPVPlayer player = MPVPlayer();
  // start the native player process
  await player.start();

  // load any file/url
  await player.load("/home/un/dev/oscVideo/test.mp4");

  // adjust volume (percentage)
  await player.volume(50);
}
