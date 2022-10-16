<template>
  <h2>content</h2>
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
      talk_themes: {},
    };
  },
  mounted() {
    axios
      .get("/api/v1/categories")
      .then((response) => (this.categories = response.data));
    axios
      .get("/api/v1/talk_themes")
      .then((response) => (this.talk_themes = response.data));
  },
  methods: {
    deleteCategory(delete_id) {
      if (
        confirm(`「${this.categoryName(delete_id)}」を削除してよろしいですか?`)
      )
        axios.delete(`/api/v1/categories/${delete_id}`).then(() => {
          this.updateContents();
        });
    },
    deleteTalkTheme(delete_id) {
      if (
        confirm(
          `「${this.talkThemeContent(delete_id)}」を削除してよろしいですか?`
        )
      )
        axios.delete(`/api/v1/categories/${delete_id}`).then(() => {
          this.updateContents();
        });
    },
    categoryName(delete_id) {
      const filterDate = this.categories.filter(
        (category) => category.id === delete_id
      );
      return filterDate[0].name;
    },
    talkThemeContent(delete_id) {
      const filterDate = this.talk_themes.filter(
        (talk_theme) => talk_theme.id === delete_id
      );
      return filterDate[0].content;
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
