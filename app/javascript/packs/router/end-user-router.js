import { createRouter, createWebHistory } from "vue-router";
import RoulettePage from "../../end_user/RoulettePage.vue";
import ContentIndexPage from "../../end_user/ContentIndexPage.vue";

const routes = [
  { path: "/", 
    component: RoulettePage },
  { path: "/content", 
    component: ContentIndexPage },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
