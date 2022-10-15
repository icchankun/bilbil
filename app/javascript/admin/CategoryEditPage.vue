<template>
  <form @submit.prevent="updateCategory">
    <error-message-display :errors="errors"></error-message-display>
    <div>
      <input v-model="category.name" type="text" />
    </div>
    <button type="submit">カテゴリーを更新</button>
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
      category: {},
      errors: "",
    };
  },
  mounted() {
    axios
      .get(`/api/v1/categories/${this.$route.params.id}`)
      .then((response) => (this.category = response.data));
  },
  methods: {
    updateCategory: function () {
      axios
        .patch(`/api/v1/categories/${this.category.id}`, this.category)
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
