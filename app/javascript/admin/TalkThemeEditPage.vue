<template>
  <form @submit.prevent="updateTalkTheme">
    <error-message-display :errors="errors"></error-message-display>
    <div><input v-model="talk_theme.content" type="text" /> ?</div>
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
    <button type="submit">トークテーマを更新</button>
  </form>
</template>

<script>
import axios from "axios";

import ErrorMessageDisplay from "./components/ErrorMessageDisplay.vue";

export default {
  components: {
    ErrorMessageDisplay,
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
