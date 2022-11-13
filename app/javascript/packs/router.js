import { createRouter, createWebHistory } from "vue-router";
import RoulettePage from "../end_user/RoulettePage.vue";
import EndUserContentIndexPage from "../end_user/ContentIndexPage.vue";
import HowToUsePage from "../end_user/HowToUsePage.vue";
import AdminContentIndexPage from "../admin/ContentIndexPage.vue";
import ContentNewPage from "../admin/ContentNewPage.vue";
import CategoryEditPage from "../admin/CategoryEditPage.vue";
import TalkThemeEditPage from "../admin/TalkThemeEditPage.vue";

const routes = [
  { path: "/", component: RoulettePage },
  { path: "/content", component: EndUserContentIndexPage },
  { path: "/guide", component: HowToUsePage },
  { path: "/admin", component: AdminContentIndexPage },
  { path: "/admin/content/new", component: ContentNewPage },
  {
    path: "/admin/categories/:id(\\d+)/edit",
    name: "CategoryEditPage",
    component: CategoryEditPage,
  },
  {
    path: "/admin/talk_themes/:id(\\d+)/edit",
    name: "TalkThemeEditPage",
    component: TalkThemeEditPage,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;