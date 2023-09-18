import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

console.log('search', location.search);

createApp(App).use(router).mount('#app')
