import { createRouter, createWebHashHistory } from "vue-router";
import ContentIndexPage from "../../admin/ContentIndexPage.vue";
import ContentNewPage from "../../admin/ContentNewPage.vue";
import CategoryEditPage from "../../admin/CategoryEditPage.vue";
import TalkThemeEditPage from "../../admin/TalkThemeEditPage.vue";

const routes = [
  { path: "/", 
    component: ContentIndexPage },
  { path: "/content/new", 
    component: ContentNewPage },
  { path: '/categories/:id(\\d+)/edit',
    name: 'CategoryEditPage',
    component: CategoryEditPage  },
  { path: '/talk_themes/:id(\\d+)/edit',
    name: 'TalkThemeEditPage',
    component: TalkThemeEditPage  },
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
