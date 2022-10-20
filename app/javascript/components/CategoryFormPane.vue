<template>
  <form @submit.prevent="onSubmit()">
    <error-message-display :errors="errors"></error-message-display>
    <div class="row justify-content-center mb-4">
      <div class="col-7">
        <input class="form-control" v-model="category.name" type="text" />
      </div>
    </div>
    <div class="text-center">
      <button class="btn btn-success" type="submit"><slot></slot></button>
    </div>
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
