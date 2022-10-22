<template>
  <Header>C A T E G O R Y</Header>
  <div class="container">
    <div class="row my-5">
      <div class="col-lg-6 col-sm-12 mx-auto">
        <category-form-pane
          :category="category"
          :errors="errors"
          @submit="updateCategory"
          >カテゴリーを更新</category-form-pane
        >
        <content-index-button></content-index-button>
      </div>
    </div>
  </div>
  <Footer></Footer>
</template>

<script>
import axios from "axios";

import Header from "../components/Header.vue";
import CategoryFormPane from "../components/CategoryFormPane.vue";
import ContentIndexButton from "../components/ContentIndexButton.vue";
import Footer from "../components/Footer.vue";

export default {
  components: {
    Header,
    CategoryFormPane,
    ContentIndexButton,
    Footer,
  },
  data() {
    return {
      category: {},
      errors: "",
    };
  },
  mounted() {
    axios
      .get(`/api/v1/categories/${this.$route.params.id}`)
      .then((response) => (this.category = response.data));
  },
  methods: {
    updateCategory: function () {
      axios
        .patch(`/api/v1/categories/${this.category.id}`, this.category)
        .then(() => {
          this.$router.push({ path: "/" });
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
