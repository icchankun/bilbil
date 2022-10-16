<template>
  <category-form-pane :category="category" :errors="errors" @submit="updateCategory">カテゴリーを更新</category-form-pane>
</template>

<script>
import axios from "axios";

import CategoryFormPane from "../components/CategoryFormPane.vue";

export default {
  components: {
    CategoryFormPane,
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
