<template>
  <h2>content</h2>
  <div v-if="errors.length != 0">
    <ul v-for="error in errors" :key="error">
      <li>
        <font color="red">{{ error }}</font>
      </li>
    </ul>
  </div>
  <div v-for="category in categories" :key="category.id">
    <h3>
      {{ category.name }}
      <router-link
        :to="{ name: 'CategoryEditPage', params: { id: category.id } }"
        >編集</router-link
      >
      <button @click="deleteCategory(category.id)">削除</button>
    </h3>
    <div v-for="talk_theme in category.talk_themes" :key="talk_theme.id">
      {{ talk_theme.content }}
      <router-link
        :to="{ name: 'TalkThemeEditPage', params: { id: talk_theme.id } }"
        >編集</router-link
      >
      <button @click="deleteTalkTheme(talk_theme.id)">削除</button>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      categories: {},
      errors: "",
    };
  },
  mounted() {
    axios
      .get("/api/v1/categories")
      .then((response) => (this.categories = response.data));
  },
  methods: {
    deleteCategory(delete_id) {
      axios
        .delete(`/api/v1/categories/${delete_id}`)
        .then(() => {
          this.updateContents();
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    deleteTalkTheme(delete_id) {
      axios
        .delete(`/api/v1/talk_themes/${delete_id}`)
        .then(() => {
          this.updateContents();
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    updateContents: function () {
      axios
        .get("/api/v1/categories")
        .then((response) => (this.categories = response.data));
    },
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: left;
}
</style>
