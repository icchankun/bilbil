import { createApp } from "vue";
import App from "../app.vue";
import Router from "./router/end-user-router";

document.addEventListener("DOMContentLoaded", () => {
  const app = createApp(App);
  app.use(Router);
  app.mount("#vue-app");
});
