<template>
  <Header>C A T E G O R Y</Header>
  <div class="container my-5">
    <div class="row mx-2">
      <div class="col-lg-6 mx-auto">
        <category-form-pane
          :category="category"
          :errors="errors"
          @submit="updateCategory"
          >カテゴリーを更新</category-form-pane
        >
        <content-index-page-back-button></content-index-page-back-button>
      </div>
    </div>
  </div>
  <admin-footer></admin-footer>
</template>

<script>
import axios from "axios";

import Header from "../components/Header.vue";
import CategoryFormPane from "../components/CategoryFormPane.vue";
import ContentIndexPageBackButton from "../components/ContentIndexPageBackButton.vue";
import AdminFooter from "../components/AdminFooter.vue";

export default {
  components: {
    Header,
    CategoryFormPane,
    ContentIndexPageBackButton,
    AdminFooter,
  },
  data() {
    return {
      category: {}, // 編集するカテゴリーのデータ。
      errors: "", // 編集の際に出たエラー内容。
    };
  },
  mounted() {
    // 編集するカテゴリーのデータを取得する。
    axios
      .get(`/api/v1/categories/${this.$route.params.id}`)
      .then((response) => (this.category = response.data));
  },
  methods: {
    // 編集したカテゴリーのデータを更新する。
    updateCategory() {
      axios
        .patch(`/api/v1/categories/${this.category.id}`, this.category)
        .then(() => {
          // データ更新後は、/adminにリダイレクトする。
          this.$router.push({ path: "/admin" });
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
