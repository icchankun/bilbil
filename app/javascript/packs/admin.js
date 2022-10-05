import { createApp } from "vue";
import App from "../admin.vue";

document.addEventListener("DOMContentLoaded", () => {
  const app = createApp(App);
  app.mount("#vue-app");
});
