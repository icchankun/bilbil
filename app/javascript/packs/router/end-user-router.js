import { createRouter, createWebHashHistory } from "vue-router";
import ContentIndexPage from "../../end_user/ContentIndexPage.vue";

const routes = [
  { path: "/", 
    component: ContentIndexPage },
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
