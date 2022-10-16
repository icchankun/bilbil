<template>
  <form @submit.prevent="onSubmit()">
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
    <button type="submit"><slot></slot></button>
  </form>
</template>

<script>
import ErrorMessageDisplay from "./ErrorMessageDisplay.vue";

export default {
  components: {
    ErrorMessageDisplay,
  },
  props: {
    talk_theme: {},
    categories: {},
    errors: "",
  },
  emits: ["submit"],
  methods: {
    onSubmit() {
      this.$emit("submit");
    },
  },
};
</script>

<style scoped></style>
