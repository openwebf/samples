<template>
    <h2>ActionSheet With Customize Contents</h2>
    <div class="container">
      <flutter-button type="primary" @click="showActionSheet">Click Me to Show ActionSheet</flutter-button>
  
      <flutter-action-sheet 
        :visible="visible" 
        ref="flutterActionSheets" 
        @close="handleActionClose"
        @select="handleActionSelect"  
      >
        <div class="bottom-sheet-container">
            <flutter-button @click="count++">Click Me To Increase</flutter-button>
            <div> Count Value: {{ count }} </div>
        </div>
    </flutter-action-sheet>
  
      <div class="result">visible: {{ visible }}</div>
  
      <flutter-button id="back" @click="this.$router.back()"> Back </flutter-button>
    </div>
  </template>
    
  <script>  
  export default {
    name: 'Hello-world',
    data() {
      return {
        visible: false,
        count: 0
      };
    },
    components: {
    },
    methods: {
      showActionSheet() {
        this.visible = true;
      },
      handleActionClose() {
        this.visible = false;
        this.count = 0;
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

  .bottom-sheet-container {
    height: 400px;
    padding: 20px;
  }
  </style>
    