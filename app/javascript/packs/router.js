import { createRouter, createWebHashHistory } from "vue-router";
import ContentIndexPage from "../admin/ContentIndexPage.vue";
import ContentNewPage from "../admin/ContentNewPage.vue";

const routes = [
  { path: "/", 
    component: ContentIndexPage },
  { path: "/homes/new", 
    component: ContentNewPage },
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
