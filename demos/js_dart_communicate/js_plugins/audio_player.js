class AudioPlayer {
    duration = 0;
    position = 0;
    playerState = 'stopped';

    constructor() {
      webf.methodChannel.addMethodCallHandler('setDuration', duration => {
        this.duration = duration;
        if (this.onDurationChanged != null) {
          this.onDurationChanged(this.duration);
        }
      });
      webf.methodChannel.addMethodCallHandler('setPosition', position => {
        this.position = position;
        if (this.onPositionChanged != null) {
          this.onPositionChanged(this.position);
        }
      });
      webf.methodChannel.addMethodCallHandler('setPlayerState', state => {
        this.playerState = state;
        if (this.onPlayerStateChanged != null) {
          this.onPlayerStateChanged(this.playerState);
        }
      });
    }

    play(audioPath) {
      return webf.methodChannel.invokeMethod('playAudio', audioPath);
    }

    pause() {
      return webf.methodChannel.invokeMethod('pause');
    }
}

window.audioPlayer = new AudioPlayer();