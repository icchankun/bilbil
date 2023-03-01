<template>
  <Header>C O N T E N T</Header>
  <main class="container my-5">
    <div class="row mx-2">
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
        <div class="mb-1">カテゴリーを選んでください。</div>
        <!-- カテゴリー選択ボタン -->
        <div class="d-flex flex-wrap mb-4">
          <div
            class="me-2 mb-1"
            v-for="(category, index) in categories"
            :key="category.id"
          >
            <input
              type="radio"
              class="btn-check"
              name="category"
              :id="[`category` + index]"
              :value="category.id"
              v-model="category_id"
            />
            <label
              class="btn btn-outline-secondary category_btn"
              :for="[`category` + index]"
              >{{ category.name }}</label
            >
          </div>
        </div>
        <!-- /カテゴリー選択ボタン -->
        <!-- トークテーマ検索フォーム-->
        <div class="mb-3">
          <input type="text" v-model="search_query" />
          <div @click="filteredTalkThemes($event)" class="is_filtered">検索</div>
          <div @click="filteredTalkThemes($event)" class="is_not_filtered">
            トークテーマ一覧を表示
          </div>
        </div>
        <!-- /トークテーマ検索フォーム-->
        <!-- 各カテゴリーのトークテーマ一覧 -->
        <div class="row bg-dark text-white fw-bold list_headline">
          <div class="col-12 col-sm-6">{{ category_name }}トークテーマ</div>
          <div
            v-if="talk_themes.length != 0"
            class="col-12 col-sm-6 text-sm-end"
          >
            トークテーマ数: {{ filtered_talk_themes.length }}
          </div>
        </div>
        <ol class="list">
          <!-- トークテーマが存在する場合 -->
          <div
            v-if="talk_themes.length != 0"
            v-for="talk_theme in filtered_talk_themes"
            :key="talk_theme.id"
            class="row mb-1"
          >
            <div class="col-8">
              <li>
                <span class="fw-bold">{{ talk_theme.content }} ?</span>
              </li>
            </div>
            <div class="col-4">
              <talk-theme-like-button
                :talk_theme_id="talk_theme.id"
                :likes="talk_theme.likes"
                :liked_talk_theme_ids="this.liked_talk_theme_ids"
                @addLikedTalkTheme="addLikedTalkTheme"
                @removeLikedTalkTheme="removeLikedTalkTheme"
              ></talk-theme-like-button>
            </div>
          </div>
          <!-- /トークテーマが存在する場合 -->
          <!-- トークテーマが存在しない場合 -->
          <div v-else class="fw-bold text-center py-2 pe-2">
            トークテーマはありません。
          </div>
          <!-- /トークテーマが存在しない場合 -->
        </ol>
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
    this.categoryDefault();
    this.fetchLikedTalkThemeIds();
  },
  data() {
    return {
      categories: [], // 全カテゴリーのデータの配列。
      category_id: "", // 選択されたカテゴリーのid。
      category_name: "", // 選択されたカテゴリーのカテゴリー名。
      talk_themes: [], // 選択したカテゴリーのトークテーマの配列。
      filtered_talk_themes: [], // 選択したカテゴリーのトークテーマの配列。
      search_query: "", // 検索フォームに入力された文字列
      liked_talk_theme_ids: [], // いいねをしたトークテーマのidの配列。
    };
  },
  watch: {
    //いいねをしたトークテーマのidの配列に変化があった時、トークテーマの並び替えを行う。
    liked_talk_theme_ids: {
      handler() {
        this.sortTalkThemes
      },
      deep: true,
    },

    // 選択したカテゴリーが変わるごとに、ルーレットの内容と取得するカテゴリー名を変更する。
    category_id: async function () {
      await this.separateTalkThemesByCategory();
      this.sortTalkThemes;
    },
  },
  computed: {
    sortTalkThemes() {
      this.sortTalkThemesByPopularity
      this.sortLikedTalkThemes
    },

    // トークテーマをいいね数が多い順に並び替える。
    sortTalkThemesByPopularity() {
      this.filtered_talk_themes.sort((a, b) => {
        return b.likes.length - a.likes.length;
      });
    },

    // いいねをしたトークテーマをトークテーマ一覧の上部に表示させる。
    sortLikedTalkThemes() {
      const ids = this.liked_talk_theme_ids;

      this.filtered_talk_themes.sort((a, b) => {
        if (ids.includes(a.id)) {
          return -1;
        } else if (ids.includes(b.id)) {
          return 1;
        } else {
          return 0;
        }
      });
    },
  },
  methods: {
    // 全カテゴリーのデータを取得する。
    async fetchCategories() {
      await axios.get("/api/v1/categories").then((response) => {
        this.categories = response.data;
      });
    },

    async categoryDefault() {
      await this.fetchCategories();

      // 選択されたカテゴリーの初期値をカテゴリーデータの先頭にする。
      this.category_id = this.categories[0].id;
    },

    async separateTalkThemesByCategory() {
      this.fetchCategories();

      // 選択したカテゴリーのデータを変数に代入する。
      const selected_category = this.categories.find(
        (category) => category.id == this.category_id
      );

      // 選択したカテゴリーのカテゴリー名とトークテーマをdataプロパティに代入する。
      this.category_name = selected_category.name;
      this.talk_themes = selected_category.talk_themes;

      // 選択したカテゴリーのトークテーマを別のdataプロパティに再代入する。
      this.filtered_talk_themes = this.talk_themes;
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

    // 検索フォームに入力した文字列をもとにトークテーマを検索する。
    async filteredTalkThemes(e) {
      await this.separateTalkThemesByCategory();

      if (e.target.className == "is_filtered") {
        this.filtered_talk_themes = this.talk_themes.filter((talk_theme) => {
          return this.search_query
            .split(/\s+/)
            .map((query) => talk_theme.content.indexOf(query) > -1)
            .some((result) => result === true);
        });
      } else {
        this.filtered_talk_themes = this.talk_themes;
      }

      this.sortTalkThemes;
    },
  },
};
</script>

<style scoped>
</style>
