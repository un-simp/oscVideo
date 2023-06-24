import 'dart:io';
import 'package:mpv_dart/mpv_dart.dart';
import 'package:osc/osc.dart';

const int defaultPort = 4440;

void main(List<String> args) async {
  MPVPlayer player = MPVPlayer(verbose: true);
  await player.start();
  await player.fullscreen();
  await player.setProperty('keep-open', 'yes');
  await player.load("../assets/init.png");
  await player.play();
  final socket = OSCSocket(serverPort: defaultPort);
  socket.listen((msg) async {
    switch (msg.address) {
      case '/load':
        await player.load(msg.arguments[0].toString());
        await player.play();
      case '/test':
        await player.load("../assets/init.png");
        await player.play();
      case '/stop':
        await player.stop();
        exit(1);
    }
  });
}
