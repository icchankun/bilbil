<template>
  <form class="mb-5" @submit.prevent="onSubmit()">
    <error-message-display :errors="errors"></error-message-display>
    <div class="row mb-4">
      <div class="col-11">
        <input class="form-control" v-model="talk_theme.content" type="text" />
      </div>
      <span class="col-1 p-0 mt-1">?</span>
    </div>
    <div class="row mb-4">
      <div class="col-6">
        <select class="form-select" v-model="talk_theme.category_id">
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

<style scoped>
.talk_theme_name-form {
  width: 97%;
}
</style>
