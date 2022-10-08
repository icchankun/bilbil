import { createApp } from "vue";
import App from "../admin/app.vue";
import Router from "./router.js";

document.addEventListener("DOMContentLoaded", () => {
  const app = createApp(App);
  app.use(Router);
  app.mount("#vue-app");
});
