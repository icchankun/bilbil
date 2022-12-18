<template>
  <form class="mb-5" @submit.prevent="onSubmit()">
    <error-message-display :errors="errors"></error-message-display>
    <!-- カテゴリー入力フォーム -->
    <div class="row justify-content-center mb-4">
      <div class="col-7">
        <input class="form-control" v-model="category.name" type="text" />
      </div>
    </div>
    <!-- /カテゴリー入力フォーム -->
    <!-- 編集・新規登録ボタン -->
    <div class="text-center">
      <button class="btn btn-success" type="submit"><slot></slot></button>
    </div>
    <!-- 編集・新規登録ボタン -->
  </form>
</template>

<script>
import ErrorMessageDisplay from "./ErrorMessageDisplay.vue";

export default {
  components: {
    ErrorMessageDisplay,
  },
  props: {
    category: {}, // 新規登録・編集するカテゴリーのデータ。
    errors: "", // 新規登録・編集の際に出るエラー内容。
  },
  emits: ["submit"],
  methods: {
    // カテゴリーを新規登録・編集するための関数を呼び出す。
    onSubmit() {
      this.$emit("submit");
    },
  },
};
</script>

<style scoped></style>
