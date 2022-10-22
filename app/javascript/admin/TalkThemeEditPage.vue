<template>
  <Header>T H E M E</Header>
  <div class="container">
    <div class="row my-5">
      <div class="col-lg-6 col-sm-12 mx-auto">
        <talk-theme-form-pane
          :talk_theme="talk_theme"
          :categories="categories"
          :errors="errors"
          @submit="updateTalkTheme"
          >トークテーマを更新</talk-theme-form-pane
        >
        <content-index-button></content-index-button>
      </div>
    </div>
  </div>
  <Footer></Footer>
</template>

<script>
import axios from "axios";

import Header from "../components/Header.vue";
import TalkThemeFormPane from "../components/TalkThemeFormPane.vue";
import ContentIndexButton from "../components/ContentIndexButton.vue";
import Footer from "../components/Footer.vue";

export default {
  components: {
    Header,
    TalkThemeFormPane,
    ContentIndexButton,
    Footer,
  },
  data() {
    return {
      talk_theme: {},
      categories: {},
      errors: "",
    };
  },
  mounted() {
    axios
      .get(`/api/v1/talk_themes/${this.$route.params.id}`)
      .then((response) => (this.talk_theme = response.data));
    axios
      .get("/api/v1/categories")
      .then((response) => (this.categories = response.data));
  },
  methods: {
    updateTalkTheme: function () {
      axios
        .patch(`/api/v1/talk_themes/${this.talk_theme.id}`, this.talk_theme)
        .then(() => {
          this.$router.push({ path: "/" });
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
