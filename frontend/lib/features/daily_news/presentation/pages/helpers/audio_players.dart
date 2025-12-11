import 'package:audioplayers/audioplayers.dart';

final AudioPlayer _audioPlayer = AudioPlayer();

void playClickSound() async {
  await _audioPlayer.play(AssetSource('sounds/just_pop.mp3'));
}
