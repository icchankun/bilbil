<template>
  <Header>C O N T E N T</Header>
  <main class="container">
    <div class="row mx-2 my-5">
      <div class="col-lg-7 mx-auto">
        <!-- ページ説明文 -->
        <div class="mb-3">
          <div class="mb-2">
            このアプリで出題されるトークテーマを各カテゴリーごと
            にまとめています。
          </div>
          <div class="mb-2">
            また、トークテーマにいいねをすることができます。
          </div>
          <div>
            いいねをしたトークテーマは各カテゴリーのトークテーマ一覧の上部に表示されます。
          </div>
        </div>
        <!-- /ページ説明文 -->
        <!-- ページ遷移リンク -->
        <div class="mb-3">
          <div class="mb-2 text-center">
            <router-link class="py-1" to="/guide"
              >ご利用ガイドはこちらから。</router-link
            >
          </div>
          <roulette-page-back-button></roulette-page-back-button>
        </div>
        <!-- /ページ遷移リンク -->
        <!-- 各カテゴリーのトークテーマ一覧 -->
        <div class="mb-3">
          <div
            class="row dropdown"
            v-for="category in categories"
            :key="category.id"
          >
            <button
              type="button"
              class="btn btn-dark dropdown-toggle"
              data-bs-toggle="dropdown"
              data-bs-auto-close="false"
            >
              <div class="d-inline-block col-11 text-start">
                {{ category.name }}
              </div>
            </button>
            <ol class="dropdown-menu p-0">
              <li
                v-if="category.talk_themes.length != 0"
                v-for="talk_theme in category.talk_themes"
                :key="talk_theme.id"
                class="dropdown-item"
              >
                <div class="row d-inline-flex flex-wrap">
                  <div class="col-9 fw-bold text-wrap">
                    {{ talk_theme.content }} ?
                  </div>
                  <div class="col-3">
                    <talk-theme-like-button
                      :talk_theme_id="talk_theme.id"
                      :likes="talk_theme.likes"
                      :liked_talk_theme_ids="this.liked_talk_theme_ids"
                      @addLikedTalkTheme="addLikedTalkTheme"
                      @removeLikedTalkTheme="removeLikedTalkTheme"
                    ></talk-theme-like-button>
                  </div>
                </div>
              </li>
              <li v-else>
                <div class="fw-bold p-2">
                  トークテーマはありません。
                </div>
              </li>
            </ol>
          </div>
        </div>
        <!-- /各カテゴリーのトークテーマ一覧 -->
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
  created() {
    this.fetchCategories();
    this.fetchLikedTalkThemeIds();
  },
  data() {
    return {
      categories: [], // 全カテゴリーのデータの配列。
      liked_talk_theme_ids: [], // いいねをしたトークテーマのidの配列。
    };
  },
  watch: {
    //いいねをしたトークテーマのidの配列に変化があった時、トークテーマの並び替えを行う。
    liked_talk_theme_ids: {
      handler() {
        this.sortedTalkThemesByLikes;
      },
      deep: true,
    },
  },
  computed: {
    // いいねをしたトークテーマをトークテーマ一覧の上部に表示させる。
    sortedTalkThemesByLikes() {
      const ids = this.liked_talk_theme_ids;

      return this.categories.forEach((category) => {
        category.talk_themes.sort((a, b) => {
          if (ids.includes(a.id)) {
            return -1;
          } else if (ids.includes(b.id)) {
            return 1;
          } else {
            return 0;
          }
        });
      });
    },
  },
  methods: {
    // 全カテゴリーのデータを取得し、トークテーマの並び替えを行う。
    fetchCategories() {
      axios.get("/api/v1/categories").then((response) => {
        this.categories = response.data;
        this.sortedTalkThemesByLikes;
      });
    },

    // 接続しているipアドレスをipカラムに保存しているいいねレコードのトークテーマidカラムの値を配列にし、取得する。
    
    fetchLikedTalkThemeIds() {
      axios.get("/api/v1/like/ip").then((response) => {
        this.liked_talk_theme_ids = response.data;
      });
    },

    // いいねをしたトークテーマのidの配列に、新たにいいねをしたトークテーマのidを追加する。
    addLikedTalkTheme(talk_theme_id) {
      this.liked_talk_theme_ids.push(talk_theme_id);
    },

    // いいねをしたトークテーマのidの配列から、いいねを解除したトークテーマのidを削除する。
    removeLikedTalkTheme(talk_theme_id) {
      const ids = this.liked_talk_theme_ids.filter((id) => id != talk_theme_id);
      this.liked_talk_theme_ids = ids;
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
