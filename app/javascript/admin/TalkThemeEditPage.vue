<template>
  <Header>T H E M E</Header>
  <div class="container my-5">
    <div class="row mx-2">
      <div class="col-lg-6 mx-auto">
        <talk-theme-form-pane
          :talk_theme="talk_theme"
          :categories="categories"
          :errors="errors"
          @submit="updateTalkTheme"
          >トークテーマを更新</talk-theme-form-pane
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
import TalkThemeFormPane from "../components/TalkThemeFormPane.vue";
import ContentIndexPageBackButton from "../components/ContentIndexPageBackButton.vue";
import AdminFooter from "../components/AdminFooter.vue";

export default {
  components: {
    Header,
    TalkThemeFormPane,
    ContentIndexPageBackButton,
    AdminFooter,
  },
  data() {
    return {
      talk_theme: {}, // 編集するトークテーマのデータ。
      categories: {}, // 全カテゴリーのデータ。
      errors: "", // 編集した際に出たエラー内容。
    };
  },
  mounted() {
    // 編集するトークテーマのデータを取得する。
    axios
      .get(`/api/v1/talk_themes/${this.$route.params.id}`)
      .then((response) => (this.talk_theme = response.data));

    // 全カテゴリーのデータを取得する。
    axios
      .get("/api/v1/categories")
      .then((response) => (this.categories = response.data));
  },
  methods: {
    // 特定のトークテーマのデータを更新する。
    updateTalkTheme: function () {
      axios
        .patch(`/api/v1/talk_themes/${this.talk_theme.id}`, this.talk_theme)
        .then(() => {
          // データ更新後は、/adminにリダイレクトする。
          this.$router.push({ path: "/admin" });
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
  },
};
</script>

<style scoped></style>
