import { createRouter, createWebHashHistory } from "vue-router";
import TalkThemeRoulettePage from "../../end_user/TalkThemeRoulettePage.vue";
import ContentIndexPage from "../../end_user/ContentIndexPage.vue";

const routes = [
  { path: "/", 
    component: TalkThemeRoulettePage },
  { path: "/content", 
    component: ContentIndexPage },
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
