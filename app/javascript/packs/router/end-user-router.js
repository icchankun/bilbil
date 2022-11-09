import { createRouter, createWebHistory } from "vue-router";
import RoulettePage from "../../end_user/RoulettePage.vue";
import ContentIndexPage from "../../end_user/ContentIndexPage.vue";
import HowToUsePage from "../../end_user/HowToUsePage.vue";

const routes = [
  { path: "/", 
    component: RoulettePage },
  { path: "/content", 
    component: ContentIndexPage },
  { path: "/guide", 
    component: HowToUsePage },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
