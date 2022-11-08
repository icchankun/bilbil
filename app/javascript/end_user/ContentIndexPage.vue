<template>
  <Header>C O N T E N T</Header>
  <main class="container">
    <div class="row my-5">
      <div class="col-lg-6 mx-auto">
        <root-path-button>トップページに戻る</root-path-button>
        <div class="mt-5">
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
            <ol class="dropdown-menu p-0">
              <li
                v-for="(talk_theme, index) in category.talk_themes"
                :key="talk_theme.id"
                v-if="category.talk_themes.length != 0"
                class="dropdown-item"
                :class="[index + 1 == this.ip_count ? 'boundary_line' : '']"
              >
                <dl class="row d-inline-flex flex-wrap m-0">
                  <dt class="col-12 col-sm-11 text-wrap">
                    {{ talk_theme.content }} ?
                  </dt>
                  <dd class="col-1">
                    <talk-theme-like-button
                      :talk_theme_id="talk_theme.id"
                      :likes="talk_theme.likes"
                      @fetchCategories="fetchCategories"
                      @addBorderToTheLastLike="addBorderToTheLastLike"
                    ></talk-theme-like-button>
                  </dd>
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
    </div>
  </main>
  <end-user-footer></end-user-footer>
</template>

<script>
import axios from "axios";

import Header from "../components/Header.vue";
import TalkThemeLikeButton from "../components/TalkThemeLikeButton.vue";
import RootPathButton from "../components/RootPathButton.vue";
import EndUserFooter from "../components/EndUserFooter.vue";

export default {
  components: {
    Header,
    TalkThemeLikeButton,
    RootPathButton,
    EndUserFooter,
  },
  data() {
    return {
      categories: {},
      talk_themes: {},
      liked_talk_themes: [],
      ip_count: {},
    };
  },
  created() {
    this.addBorderToTheLastLike();
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
      const talk_theme_ids = [];
      this.liked_talk_themes.forEach((like) => {
        talk_theme_ids.push(like.talk_theme_id);
      });
      console.log(talk_theme_ids);

      const talk_themes_sorted = [];
      this.categories.forEach((category) => {
        category.talk_themes.sort((a, b) => {
          if (talk_theme_ids.includes(a.id)) {
            return -1;
          } else if (talk_theme_ids.includes(b.id)) {
            return 1;
          } else {
            return 0;
          }
        });
        talk_themes_sorted.push(category);
      });
      return talk_themes_sorted;
    },
    addBorderToTheLastLike() {
      axios.get("/api/v1/like/ip").then((response) => {
        this.liked_talk_themes = response.data;
        this.ip_count = response.data.length;
      });
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

<style lang="scss" scoped>
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
  &.boundary_line {
    border-bottom: 2px solid #000;
  }
}

.d-inline-flex {
  width: 95%;
}
</style>
