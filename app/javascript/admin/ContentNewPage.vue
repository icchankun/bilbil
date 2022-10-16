<template>
  <talk-theme-form-pane :talk_theme="talk_theme" :categories="categories" :errors="talk_theme.errors" @submit="createTalkTheme"></talk-theme-form-pane>
  <category-form-pane :category="category" :errors="category.errors" @submit="createCategory"></category-form-pane>
</template>

<script>
import axios from "axios";

import TalkThemeFormPane from "./components/TalkThemeFormPane.vue";
import CategoryFormPane from "./components/CategoryFormPane.vue";

export default {
  components: {
    TalkThemeFormPane,
    CategoryFormPane,
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
