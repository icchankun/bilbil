import { createRouter, createWebHistory } from "vue-router";
import ContentIndexPage from "../../admin/ContentIndexPage.vue";
import ContentNewPage from "../../admin/ContentNewPage.vue";
import CategoryEditPage from "../../admin/CategoryEditPage.vue";
import TalkThemeEditPage from "../../admin/TalkThemeEditPage.vue";

const routes = [
  { path: "/admin", 
    component: ContentIndexPage },
  { path: "/admin/content/new", 
    component: ContentNewPage },
  { path: '/admin/categories/:id(\\d+)/edit',
    name: 'CategoryEditPage',
    component: CategoryEditPage  },
  { path: '/admin/talk_themes/:id(\\d+)/edit',
    name: 'TalkThemeEditPage',
    component: TalkThemeEditPage  },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
