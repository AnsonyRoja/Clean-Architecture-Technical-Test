import 'package:audioplayers/audioplayers.dart';

final AudioPlayer _audioPlayer = AudioPlayer();

void playClickSound(AssetSource sound) async {
  print('Sonido $sound');
  await _audioPlayer.play(sound);
}
