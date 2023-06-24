import 'dart:io';

import 'package:mpv_dart/mpv_dart.dart';
import 'package:osc/osc.dart';
// import 'dart:io';

// void main() async {
//   MPVPlayer player = MPVPlayer(
//     verbose: true,
//   );

// // start the native player process
// await player.start();
// await player.fullscreen();
// await player.setProperty('keep-open', 'yes');
// // load any file/url
// String? name = stdin.readLineSync();
// await player.load("/home/unsimp/Desktop/oscVideo/assets/init.png");
//   String? nae = stdin.readLineSync();
//   await player.load("/home/unsimp/Desktop/oscVideo/test.mp4");
//   await player.play();
//   // adjust volume (percentage)
//   await player.volume(100);
//   stdin.readLineSync();
//   await player.stop();
// }

const int defaultPort = 4440;

/// simple echo server; useful for testing.
void main(List<String> args) async {
  MPVPlayer player = MPVPlayer(verbose: true);
  await player.start();
  await player.fullscreen();
  await player.setProperty('keep-open', 'yes');
  await player.load("../assets/init.png");
  final port = args.length == 1 ? int.parse(args[0]) : defaultPort;

  print('echo osc listening on port $port... (^C to quit)');

  final socket = OSCSocket(serverPort: port);
  socket.listen((msg) async {
    print("received: ${msg.toString()}");
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
