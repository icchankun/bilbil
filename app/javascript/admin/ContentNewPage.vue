<template>
  <Header>C R E A T E</Header>

  <div class="container">
    <div class="row my-5">
      <div class="col-lg-6 col-sm-12 mx-auto">
        <headline>THEHE</headline>
        <div>
          {{ create_talk_theme.content }}
          {{ create_talk_theme.category }}
        </div>
        <talk-theme-form-pane
          :talk_theme="talk_theme"
          :categories="categories"
          :errors="talk_theme.errors"
          @submit="createTalkTheme"
          >トークテーマを作成</talk-theme-form-pane
        >
        <headline>CATEGORY</headline>
        <div>
          {{ create_category.name }}
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
      create_talk_theme: {},
      category: {
        name: "",
        errors: "",
      },
      create_category: {},
      categories: {},
    };
  },
  mounted() {
    // 全カテゴリーを取得する
    axios
      .get("/api/v1/categories")
      .then((response) => (this.categories = response.data));
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
          this.create_talk_theme = response.data;
          this.categoryName();
          this.$router.push({ path: "/admin/content/new" });
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.talk_theme.errors = error.response.data.errors;
          }
        });
    },

    // カテゴリーを新規登録する。
    createCategory() {
      axios
        .post("/api/v1/categories", { name: this.category.name })
        .then((response) => {
          this.create_category = response.data;
          this.$router.push({ path: "/admin/content/new" });
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.category.errors = error.response.data.errors;
          }
        });
    },

    // 新規登録したトークテーマのカテゴリー名を取得する。
    categoryName() {
      const filterDate = this.categories.filter(
        (category) => category.id === this.create_talk_theme.category_id
      );
      this.create_talk_theme.category = filterDate[0].name;
    },
  },
};
</script>

<style scoped></style>
