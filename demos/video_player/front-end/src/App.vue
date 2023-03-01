<template>
  <img alt="Vue logo" src="./assets/logo.png">
  <video-player 
    ref="videoPlayer"
    src="https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"
    @canplay="handleCanPlay"
    @playing="handlePlaying"
    @paused="handlePaused"
  ></video-player>
  <div class="status-bar">
    Player Status: {{ state }}
  </div>
  <div class="video-player-control">
    <div class="control-button" @click="handlePlay">Play</div>
    <div class="control-button" @click="handlePause">Pause</div>
  </div>
  <HelloWorld msg="Welcome to Your Vue.js App"/>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue'

export default {
  name: 'App',
  components: {
    HelloWorld
  },
  data() {
    return {
      state: 'init'
    };
  },
  methods: {
    handleCanPlay() {
      this.state = 'canplay';
    }, 
    handlePlaying() {
      this.state = 'playing';
    },
    handlePaused() {
      this.state = 'paused';
    },
    handlePlay() {
      this.$refs['videoPlayer'].play();
    },
    handlePause() {
      this.$refs['videoPlayer'].pause();
    }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

.status-bar {
  padding: 10px 0 10px 0;
  text-align: center;
}

.video-player-control {
  display: flex;
  flex-direction: row;
  justify-content: space-around;
}

.video-player-control .control-button {
  width: 150px;
  padding: 10px 0 10px 0;
  border: 1px solid #000;
  text-align: center;
}
</style>
