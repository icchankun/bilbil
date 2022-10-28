<template>
  <Header>C O N T E N T</Header>
  <main class="container">
    <div class="row my-5">
      <div class="col-lg-6 mx-auto">
        <div
          class="row dropdown"
          v-for="category in categories"
          :key="category.id"
        >
          <button
            type="button"
            class="btn btn-dark dropdown-toggle py-2"
            data-bs-toggle="dropdown"
            data-bs-auto-close="false"
          >
            <div class="d-inline-block col-11 text-start">
              {{ category.name }}
            </div>
          </button>
          <ol class="dropdown-menu">
            <li
              class="dropdown-item"
              v-for="talk_theme in category.talk_themes"
              :key="talk_theme.id"
              v-if="category.talk_themes.length != 0"
            >
              <dl class="d-inline-flex flex-wrap m-0">
                <dt class="mb-2 text-wrap">{{ talk_theme.content }} ?</dt>
                <talk-theme-like-button
                  :talk_theme_id="talk_theme.id"
                  :likes="talk_theme.likes"
                ></talk-theme-like-button>
              </dl>
            </li>
            <li class="d-block px-1 py-2" v-else>
              <dl class="m-0">
                <dt>トークテーマはありません。</dt>
              </dl>
            </li>
          </ol>
        </div>
      </div>
    </div>
  </main>
  <Footer></Footer>
</template>

<script>
import axios from "axios";

import Header from "../components/Header.vue";
import TalkThemeLikeButton from "../components/TalkThemeLikeButton.vue";
import Footer from "../components/Footer.vue";

export default {
  components: {
    Header,
    TalkThemeLikeButton,
    Footer,
  },
  data() {
    return {
      categories: {},
      talk_themes: {},
    };
  },
  created() {
    this.fetchCategories();
    axios
      .get("/api/v1/talk_themes")
      .then((response) => (this.talk_themes = response.data));
  },
  methods: {
    fetchCategories: function () {
      axios
        .get("/api/v1/categories")
        .then((response) => {
          this.categories = response.data;
        })
        .then(() => (this.categories = this.sortedTalkThemesByLikes()));
    },
    sortedTalkThemesByLikes: function () {
      const talk_themes_sorted = [];
      console.log(this.categories);
      this.categories.forEach((category) => {
        talk_themes_sorted.push(category);
        return category.talk_themes.sort((a, b) => {
          return b.likes.length - a.likes.length;
        });
      });
      return talk_themes_sorted;
    },
    deleteCategory(delete_id) {
      if (
        confirm(`「${this.categoryName(delete_id)}」を削除してよろしいですか?`)
      )
        axios.delete(`/api/v1/categories/${delete_id}`).then(() => {
          this.fetchCategories();
        });
    },
    deleteTalkTheme(delete_id) {
      if (
        confirm(
          `「${this.talkThemeContent(delete_id)}」を削除してよろしいですか?`
        )
      )
        axios.delete(`/api/v1/talk_themes/${delete_id}`).then(() => {
          this.fetchCategories();
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
  },
};
</script>

<style scoped>
.bg-dark {
  border-bottom: 1px solid #fff;
}
.dropdown-toggle {
  border-radius: 0;
  border-bottom: 1px solid #fff;
}

.dropdown-menu {
  position: static !important;
  transform: translate(0, 0) !important;
  border-radius: 0;
}
.dropdown-item {
  display: list-item;
  list-style: decimal inside;
}

.d-inline-flex {
  width: 95%;
}
</style>
