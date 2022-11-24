<template>
  <h2>ActionSheet Demo</h2>
  <div class="container">
    <flutter-button type="primary" @click="showActionSheet">Click Me to Show ActionSheet</flutter-button>

    <flutter-action-sheet 
      :visible="visible" 
      ref="flutterActionSheets" 
      @close="handleActionClose"
      @select="handleActionSelect"  
    ></flutter-action-sheet>

    <div class="result">Selected value: {{ selectedValue }}</div>

    <flutter-button id="back" @click="this.$router.back()"> Back </flutter-button>
  </div>
</template>
  
<script>
function makeid(length) {
  var result = '';
  var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  var charactersLength = characters.length;
  for (var i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
}

export default {
  name: 'Hello-world',
  data() {
    return {
      visible: false,
      actions: [],
      selectedValue: null
    };
  },
  components: {
  },
  methods: {
    showActionSheet() {
      this.visible = true;

      let actions = [];
      for (let i = 0; i < 10; i++) {
        actions.push({
          name: makeid(10),
          value: i
        })
      }

      this.$refs['flutterActionSheets'].actions = actions;
    },
    handleActionClose() {
      this.visible = false;
    },
    handleActionSelect(e) {
      this.selectedValue = e.detail;
    }
  }
}
</script>
  
<style>
h2 {
  text-align: center;
}

.container {
  padding: 10px;
  text-align: center;
}

.container > flutter-button {
  color: white;
}

.result {
  margin-top: 20px;
}

#back {
  display: block;
  margin: 20px auto 0 auto;
  color: black;
}
</style>
  