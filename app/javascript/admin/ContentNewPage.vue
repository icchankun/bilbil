<template>
  <Header>C R E A T E</Header>
  <div class="container">
    <div class="row my-5">
      <div class="col-12 col-lg-6 mx-auto">
        <headline>THEHE</headline>
        <div v-if="Boolean(created_talk_theme.content)">
          {{ created_talk_theme.content }}
          {{ created_talk_theme.category }}
          <router-link
            class=""
            :to="{
              name: 'TalkThemeEditPage',
              params: { id: created_talk_theme.id },
            }"
            >編集</router-link
          >
        </div>
        <talk-theme-form-pane
          :talk_theme="talk_theme"
          :categories="categories"
          :errors="talk_theme.errors"
          @submit="createTalkTheme"
          >トークテーマを作成</talk-theme-form-pane
        >
        <headline>CATEGORY</headline>
        <div v-if="Boolean(created_category.name)">
          {{ created_category.name }}
          <router-link
            class=""
            :to="{
              name: 'CategoryEditPage',
              params: { id: created_category.id },
            }"
            >編集</router-link
          >
        </div>
        <category-form-pane
          :category="category"
          :errors="category.errors"
          @submit="createCategory"
          >カテゴリーを作成</category-form-pane
        >
        <content-index-page-back-button></content-index-page-back-button>
      </div>
    </div>
  </div>
  <admin-footer></admin-footer>
</template>

<script>
import axios from "axios";

import Header from "../components/Header.vue";
import Headline from "../components/Headline.vue";
import TalkThemeFormPane from "../components/TalkThemeFormPane.vue";
import CategoryFormPane from "../components/CategoryFormPane.vue";
import ContentIndexPageBackButton from "../components/ContentIndexPageBackButton.vue";
import AdminFooter from "../components/AdminFooter.vue";

export default {
  components: {
    Header,
    Headline,
    TalkThemeFormPane,
    CategoryFormPane,
    ContentIndexPageBackButton,
    AdminFooter,
  },
  data() {
    return {
      talk_theme: {
        content: "",
        category_id: "",
        errors: "",
      },
      created_talk_theme: {},
      category: {
        name: "",
        errors: "",
      },
      created_category: {},
      categories: {},
    };
  },
  mounted() {
    // 全カテゴリーを取得する
    axios.get("/api/v1/categories").then((response) => {
      this.categories = response.data;
    });
  },
  methods: {
    // トークテーマを新規登録する
    createTalkTheme() {
      axios
        .post("/api/v1/talk_themes", {
          content: this.talk_theme.content,
          category_id: this.talk_theme.category_id,
        })
        .then((response) => {
          this.created_talk_theme = response.data;

          // フォームを初期状態に戻す。
          this.talk_theme.content = "";
          this.talk_theme.category_id = "";

          // エラーメッセージを削除する。
          this.talk_theme.errors = "";

          this.categoryName();
          this.$router.push({ path: "/admin/content/new" });
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            // 作成したトークテーマの表示を止める。
            this.created_talk_theme = "";

            this.talk_theme.errors = error.response.data.errors;
          }
        });
    },

    // カテゴリーを新規登録する。
    createCategory() {
      axios
        .post("/api/v1/categories", { name: this.category.name })
        .then((response) => {
          this.created_category = response.data;

          // フォームを初期状態に戻す。
          this.category.name = "";

          // エラーメッセージを削除する。
          this.category.errors = "";

          this.$router.push({ path: "/admin/content/new" });
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            // 作成したカテゴリーの表示を止める。
            this.created_category = "";

            this.category.errors = error.response.data.errors;
          }
        });
    },

    // 新規登録したトークテーマのカテゴリー名を取得する。
    categoryName() {
      const filterDate = this.categories.filter(
        (category) => category.id === this.created_talk_theme.category_id
      );
      this.created_talk_theme.category = filterDate[0].name;
    },
  },
};
</script>

<style scoped></style>
