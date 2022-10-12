<template>
  <h2>content</h2>
  <div v-for="category in categories" :key="category.id">
    <h3>{{ category.name }} <router-link :to="{ name: 'CategoryEditPage', params: { id: category.id } }">編集</router-link></h3>
    <div v-for="talk_theme in category.talk_themes" :key="talk_theme.id">
      {{ talk_theme.content }}
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      categories: {},
    };
  },
  mounted() {
    axios
      .get("/api/v1/categories")
      .then((response) => (this.categories = response.data));
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: left;
}
</style>