import { createRouter, createWebHashHistory } from "vue-router";
import ContentIndexPage from "../admin/ContentIndexPage.vue";
import ContentNewPage from "../admin/ContentNewPage.vue";
import CategoryEditPage from "../admin/CategoryEditPage.vue";

const routes = [
  { path: "/", 
    component: ContentIndexPage },
  { path: "/homes/new", 
    component: ContentNewPage },
  { path: '/categories/:id(\\d+)/edit',
    name: 'CategoryEditPage',
    component: CategoryEditPage  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
