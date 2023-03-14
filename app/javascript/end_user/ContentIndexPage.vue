<template>
  <Header>C O N T E N T</Header>
  <main class="container my-5">
    <div class="row mx-2">
      <div class="col-lg-7 mx-auto">
        <!-- ページ説明文 -->
        <div class="mb-3">
          <div class="mb-2">
            ルーレットで出題されるトークテーマを各カテゴリーごとにまとめており、それらのトークテーマには、いいねをすることができます。
          </div>
          <div class="mb-2">
            トークテーマはいいね数が多い順に並ぶようになっています。
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
        <div class="d-flex flex-wrap mb-3">
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
        <talk-theme-search-form
          :category_id="category_id"
          v-model="talk_themes"
          :liked_talk_theme_ids="liked_talk_theme_ids"
          @getValue="getValue"
        ></talk-theme-search-form>
        <!-- /トークテーマ検索フォーム-->
        <!-- 各カテゴリーのトークテーマ一覧 -->
        <div class="row bg-dark text-white fw-bold list_headline">
          <div class="col-12 col-sm-6">{{ category_name }}トークテーマ</div>
          <div
            v-if="filtered_talk_themes.length != 0"
            class="col-12 col-sm-6 text-sm-end"
          >
            トークテーマ数: {{ filtered_talk_themes.length }}
          </div>
        </div>
        <div class="list">
          <!-- トークテーマが存在する場合 -->
          <div v-if="filtered_talk_themes.length != 0">
            <div
              v-for="(talk_theme, index) in TalkThemesDividedByPages"
              :key="talk_theme.id"
              class="row"
            >
              <div class="col-8">
                <div class="talk_theme fw-bold">
                  {{ TalkThemeNumber + index }}. {{ talk_theme.content }} ?
                </div>
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
            <div class="mt-3">
              <v-pagination
                v-model="current_page"
                :pages="getPageCount"
                :range-size="1"
                active-color="#DCEDFF"
              />
            </div>
          </div>
          <!-- /トークテーマが存在する場合 -->
          <!-- トークテーマが存在しない場合 -->
          <div v-else class="fw-bold text-center py-2 pe-2">
            トークテーマはありません。
          </div>
          <!-- /トークテーマが存在しない場合 -->
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
import RoulettePageBackButton from "../components/RoulettePageBackButton.vue";
import TalkThemeSearchForm from "../components/TalkThemeSearchForm.vue";
import TalkThemeLikeButton from "../components/TalkThemeLikeButton.vue";
import VPagination from "@hennge/vue3-pagination";
import EndUserFooter from "../components/EndUserFooter.vue";

export default {
  components: {
    Header,
    RoulettePageBackButton,
    TalkThemeSearchForm,
    TalkThemeLikeButton,
    VPagination,
    EndUserFooter,
  },
  created() {
    this.categoryDefault();
    this.fetchLikedTalkThemeIds();
  },
  data() {
    return {
      categories: [], // 全カテゴリーのデータの配列。
      category_id: 0, // 選択されたカテゴリーのid。
      category_name: "", // 選択されたカテゴリーのカテゴリー名。
      talk_themes: [], // 選択したカテゴリーのトークテーマの配列。
      filtered_talk_themes: [], // 選択したカテゴリーのトークテーマの配列。
      liked_talk_theme_ids: [], // いいねをしたトークテーマのidの配列。
      current_page: 1, // トークテーマ一覧の現在ページ。
      par_page: 5, // 1ページにつき、表示されるトークテーマの数。
      display_format: "", // トークテーマの表示形式。
    };
  },
  watch: {
    // 選択したカテゴリーが変わるごとに、ルーレットの内容と取得するカテゴリー名を変更する。
    category_id: async function () {
      await this.setTalkThemesByCategory();

      if (this.display_format == "is_liked") {
        this.filtered_talk_themes = this.talk_themes.filter((talk_theme) =>
          this.liked_talk_theme_ids.includes(talk_theme.id)
        );
      }

      this.sortTalkThemesByPopularity();

      // カテゴリーが変更した際に、トークテーマ一覧のページを1にする。
      this.current_page = 1;
    },
    current_page: async function () {
      await this.UpdateTalkThemesLikes();
      this.sortTalkThemesByPopularity();
    },
    display_format: function() {
      this.sortTalkThemesByPopularity();
    }
  },
  computed: {
    // ページネーションに合わせて、トークテーマを変更する。
    TalkThemesDividedByPages() {
      let current = this.current_page * this.par_page;
      let start = current - this.par_page;
      return this.filtered_talk_themes.slice(start, current);
    },

    // トークテーマの番号を算出し、返す。
    TalkThemeNumber() {
      return (this.current_page - 1) * this.par_page + 1;
    },

    // トークテーマのページ数を算出し、返す。
    getPageCount() {
      return Math.ceil(this.filtered_talk_themes.length / this.par_page);
    },
  },
  methods: {
    // 全カテゴリーのデータを取得する。
    async fetchCategories() {
      const response = await axios.get("/api/v1/categories");
      this.categories = response.data;
    },

    async categoryDefault() {
      await this.fetchCategories();

      // 選択されたカテゴリーの初期値をカテゴリーデータの先頭にする。
      this.category_id = this.categories[0].id;
    },

    async changeCategory() {
      // 選択したカテゴリーのデータを変数に代入する。
      const selected_category = this.categories.find(
        (category) => category.id == this.category_id
      );

      // 選択したカテゴリーのカテゴリー名とトークテーマをdataプロパティに代入する。
      this.category_name = selected_category.name;
      this.talk_themes = selected_category.talk_themes;
    },

    // 各カテゴリーごとにトークテーマを分ける。
    async setTalkThemesByCategory() {
      await this.fetchCategories();
      await this.changeCategory();

      // 取得したトークテーマを全てfiltered_talk_themesに代入する。
      this.filtered_talk_themes = this.talk_themes;
    },

    // 各トークテーマのいいね数を更新する。
    async UpdateTalkThemesLikes() {
      await this.fetchCategories();
      await this.changeCategory();

      // 取得したトークテーマのうち、filtered_talk_themesに代入されていたものを、filtered_talk_themesに再代入する。
      const filtered_talk_themes_ids = this.filtered_talk_themes.map(
        (talk_theme) => talk_theme.id
      );
      this.filtered_talk_themes = this.talk_themes.filter((talk_theme) =>
        filtered_talk_themes_ids.includes(talk_theme.id)
      );
    },

    // トークテーマをいいね数が多い順に並び替える。
    sortTalkThemesByPopularity() {
      this.filtered_talk_themes.sort((a, b) => {
        return b.likes.length - a.likes.length;
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
    
    // 接続しているipアドレスをipカラムに保存しているいいねレコードのトークテーマidカラムの値を配列にし、取得する。
    fetchLikedTalkThemeIds() {
      axios.get("/api/v1/like/ip").then((response) => {
        this.liked_talk_theme_ids = response.data;
      });
    },

    // トークテーマの表示形式、検索したトークテーマのデータをdataプロパティに代入する。
    getValue(display_format, filtered_talk_themes) {
      this.display_format = display_format;
      this.filtered_talk_themes = filtered_talk_themes;
      this.current_page = 1;
    },
  },
};
</script>

<style scoped></style>
