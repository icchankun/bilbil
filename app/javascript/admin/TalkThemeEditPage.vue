<template>
  <talk-theme-form-pane :talk_theme="talk_theme" :categories="categories" :errors="errors" @submit="updateTalkTheme">トークテーマを更新</talk-theme-form-pane>
</template>

<script>
import axios from "axios";

import TalkThemeFormPane from "./components/TalkThemeFormPane.vue";

export default {
  components: {
    TalkThemeFormPane,
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
