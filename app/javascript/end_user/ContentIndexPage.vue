<template>
  <Header>C O N T E N T</Header>
  <main class="container">
    <div class="row my-5">
      <div class="col-lg-7 mx-auto">
        <div class="mb-3">
          <div class="mb-2">
            このアプリで出題されるトークテーマを各カテゴリーごと
            にまとめています。
          </div>
          <div class="mb-2">
            また、トークテーマにいいねをすることができます。
          </div>
          <div class="mb-2">
            いいねをしたトークテーマは各カテゴリーのトークテーマ一覧の上部に表示されます。
          </div>
        </div>
        <div class="mb-3 text-center">
          <router-link class="py-1" to="/guide"
            >ご利用ガイドはこちらから。</router-link
          >
        </div>
        <roulette-page-back-button></roulette-page-back-button>
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
                      @fetchLikesByIpAddress="fetchLikesByIpAddress"
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
  <end-user-footer>
    いいねボタンの横にある数字は、そのトークテーマのいいね数です。
    どのトークテーマが人気なのか探してみましょう。
  </end-user-footer>
</template>

<script>
import axios from "axios";

import Header from "../components/Header.vue";
import TalkThemeLikeButton from "../components/TalkThemeLikeButton.vue";
import RoulettePageBackButton from "../components/RoulettePageBackButton.vue";
import EndUserFooter from "../components/EndUserFooter.vue";

export default {
  components: {
    Header,
    TalkThemeLikeButton,
    RoulettePageBackButton,
    EndUserFooter,
  },
  data() {
    return {
      categories: {},
      liked_talk_themes: [],
    };
  },
  created() {
    this.fetchLikesByIpAddress();
    this.fetchCategories();
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
    fetchLikesByIpAddress() {
      axios.get("/api/v1/like/ip").then((response) => {
        this.liked_talk_themes = response.data;
      });
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
