<template>
  <form @submit.prevent="onSubmit()">
    <error-message-display :errors="errors"></error-message-display>
    <div>
      <input v-model="category.name" type="text" />
    </div>
    <button type="submit">カテゴリーを作成</button>
  </form>
</template>

<script>
import ErrorMessageDisplay from "./ErrorMessageDisplay.vue";

export default {
  components: {
    ErrorMessageDisplay,
  },
  props: {
    category: {},
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
