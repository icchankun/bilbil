<template>
  <form @submit.prevent="createTalkTheme">
    <error-message-display :errors="talk_theme.errors"></error-message-display>
    <div>
      <input v-model="talk_theme.content" type="text" /> ?
    </div>
    <div>
      <select v-model="talk_theme.category_id">
        <option disabled value="">選択してください</option>
        <option
          v-for="category in categories"
          :value="category.id"
          :key="category.id"
        >
          {{ category.name }}
        </option>
      </select>
    </div>
    <button type="submit">トークテーマを作成</button>
  </form>

  <form @submit.prevent="createCategory">
    <error-message-display :errors="category.errors"></error-message-display>
    <div>
      <input v-model="category.name" type="text" />
    </div>
    <button type="submit">カテゴリーを作成</button>
  </form>
</template>

<script>
import axios from "axios";

import ErrorMessageDisplay from './components/ErrorMessageDisplay.vue';

export default {
  components: {
    ErrorMessageDisplay
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
        .post(
          "/api/v1/talk_themes",
          {
            content: this.talk_theme.content,
            category_id: this.talk_theme.category_id
          }
        )
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
        .post("/api/v1/categories", {name: this.category.name})
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
