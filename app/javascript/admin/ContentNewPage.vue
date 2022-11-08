<template>
  <Header>C R E A T E</Header>

  <div class="container">
    <div class="row my-5">
      <div class="col-lg-6 col-sm-12 mx-auto">
        <headline>THEHE</headline>
        <talk-theme-form-pane
          :talk_theme="talk_theme"
          :categories="categories"
          :errors="talk_theme.errors"
          @submit="createTalkTheme"
          >トークテーマを作成</talk-theme-form-pane
        >
        <headline>CATEGORY</headline>
        <category-form-pane
          :category="category"
          :errors="category.errors"
          @submit="createCategory"
          >カテゴリーを作成</category-form-pane
        >
        <root-path-button>コンテンツ一覧に戻る</root-path-button>
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
import RootPathButton from "../components/RootPathButton.vue";
import AdminFooter from "../components/AdminFooter.vue";

export default {
  components: {
    Header,
    Headline,
    TalkThemeFormPane,
    CategoryFormPane,
    RootPathButton,
    AdminFooter,
  },
  data() {
    return {
      talk_theme: {
        content: "",
        category_id: "",
        errors: "",
      },
      category: {
        name: "",
        errors: "",
      },
      categories: {},
    };
  },
  mounted() {
    axios
      .get("/api/v1/categories")
      .then((response) => (this.categories = response.data));
  },
  methods: {
    createTalkTheme: function () {
      axios
        .post("/api/v1/talk_themes", {
          content: this.talk_theme.content,
          category_id: this.talk_theme.category_id,
        })
        .then(() => {
          this.$router.push({ path: "/" });
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.talk_theme.errors = error.response.data.errors;
          }
        });
    },
    createCategory: function () {
      axios
        .post("/api/v1/categories", { name: this.category.name })
        .then(() => {
          this.$router.push({ path: "/" });
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.category.errors = error.response.data.errors;
          }
        });
    },
  },
};
</script>

<style scoped></style>
