<template>
  <form @submit.prevent="updateCategory">
    <div v-if="errors.length != 0">
      <ul v-for="error in errors" :key="error">
        <li>
          <font color="red">{{ error }}</font>
        </li>
      </ul>
    </div>
    <div>
      <input v-model="category.name" type="text" />
    </div>
    <button type="submit">カテゴリーを更新</button>
  </form>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      category: {},
      errors: ''
    }
  },
  mounted () {
    axios
      .get(`/api/v1/categories/${this.$route.params.id}`)
      .then(response => (this.category = response.data))
  },
  methods: {
    updateCategory: function() {
      axios
        .patch(`/api/v1/categories/${this.category.id}`, this.category)
        .then(() => {
          this.$router.push({ path: "/" });
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  }
}
</script>

<style scoped></style>
