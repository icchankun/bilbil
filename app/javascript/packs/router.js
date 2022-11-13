import { createRouter, createWebHistory } from "vue-router";
import RoulettePage from "../end_user/RoulettePage.vue";
import EndUserContentIndexPage from "../end_user/ContentIndexPage.vue";
import HowToUsePage from "../end_user/HowToUsePage.vue";
import AdminContentIndexPage from "../admin/ContentIndexPage.vue";
import ContentNewPage from "../admin/ContentNewPage.vue";
import CategoryEditPage from "../admin/CategoryEditPage.vue";
import TalkThemeEditPage from "../admin/TalkThemeEditPage.vue";

const routes = [
  {
    path: "/",
    component: RoulettePage,
    meta: { title: "ルーレット画面" },
  },
  {
    path: "/content",
    component: EndUserContentIndexPage,
    meta: { title: "コンテンツ一覧画面" },
  },
  {
    path: "/guide",
    component: HowToUsePage,
    meta: { title: "使用方法説明画面" },
  },
  {
    path: "/admin",
    component: AdminContentIndexPage,
    meta: { title: "コンテンツ一覧画面" },
  },
  {
    path: "/admin/content/new",
    component: ContentNewPage,
    meta: { title: "トークテーマ・カテゴリー新規登録画面" },
  },
  {
    path: "/admin/categories/:id(\\d+)/edit",
    name: "CategoryEditPage",
    component: CategoryEditPage,
    meta: { title: "カテゴリー編集画面" },
  },
  {
    path: "/admin/talk_themes/:id(\\d+)/edit",
    name: "TalkThemeEditPage",
    component: TalkThemeEditPage,
    meta: { title: "トークテーマ編集画面" },
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

// タイトルを動的に変化させる。
router.afterEach((to, from) => {
  const base_title = "bilbil"
  if (to.meta && to.meta.title) {
    document.title = to.meta.title + " | " + base_title;
  }
});

export default router;
