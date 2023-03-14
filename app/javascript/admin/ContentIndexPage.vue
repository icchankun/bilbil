<template>
  <Header>C O N T E N T</Header>
  <main class="container my-5">
    <div class="row mx-2">
      <div class="col-lg-6 mx-auto">
        <!-- ページ遷移リンク -->
        <div class="mb-3">
          <div class="mb-2">
            <a class="py-1" data-method="delete" href="/admin/sign_out"
              >ログアウトする。</a
            >
          </div>
          <div>
            <router-link class="py-1" to="/admin/content/new"
              >トークテーマ・カテゴリーの作成へ。</router-link
            >
          </div>
        </div>
        <!-- /ページ遷移リンク -->
        <!-- カテゴリー選択ボタン -->
        <div class="mb-1">カテゴリーを選んでください。</div>
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
          @getValue="getValue"
        ></talk-theme-search-form>
        <!-- /トークテーマ検索フォーム-->
        <!-- 各カテゴリーのトークテーマ一覧 -->
        <div class="row bg-dark text-white fw-bold list_headline">
          <div class="col-12 col-sm-6">
            <router-link
              :to="{
                name: 'CategoryEditPage',
                params: { id: category_id },
              }"
              >{{ category_name }}</router-link
            >
            トークテーマ
          </div>
          <div class="col-12 col-sm-6 text-sm-end">
            <a
              v-if="talk_themes.length == 0"
              class="btn btn-danger btn-sm"
              @click="deleteCategory()"
              >カテゴリーを削除</a
            >
            <span v-else-if="filtered_talk_themes.length != 0"
              >トークテーマ数: {{ filtered_talk_themes.length }}</span
            >
          </div>
        </div>
        <div class="list">
          <!-- トークテーマが存在する場合 -->
          <div v-if="filtered_talk_themes.length != 0">
            <div
              v-for="(talk_theme, index) in TalkThemesDividedByPages"
              :key="talk_theme.id"
              class="row mb-2"
            >
              <div class="col-12 col-sm-6">
                <div class="talk_theme">
                  <router-link
                    :to="{
                      name: 'TalkThemeEditPage',
                      params: { id: talk_theme.id },
                    }"
                    ><span class="fw-bold"
                      >{{ TalkThemeNumber + index }}.
                      {{ talk_theme.content }}?</span
                    ></router-link
                  >
                </div>
              </div>
              <div class="col-12 col-sm-6">
                <a
                  class="btn btn-danger btn-sm me-2"
                  @click="deleteTalkTheme(talk_theme.id)"
                  >{{ TalkThemeNumber + index }}を削除</a
                >
                <span> いいね数: {{ talk_theme.likes.length }} </span>
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
  <admin-footer></admin-footer>
</template>

<script>
import axios from "axios";

import Header from "../components/Header.vue";
import TalkThemeSearchForm from "../components/TalkThemeSearchForm.vue";
import VPagination from "@hennge/vue3-pagination";
import AdminFooter from "../components/AdminFooter.vue";

export default {
  components: {
    Header,
    TalkThemeSearchForm,
    VPagination,
    AdminFooter,
  },
  created() {
    this.categoryDefault();
  },
  data() {
    return {
      categories: [], // 全カテゴリーのデータの配列。
      category_id: 0, // 選択されたカテゴリーのid。
      category_name: "", // 選択されたカテゴリーのカテゴリー名
      talk_themes: [], // 選択したカテゴリーのトークテーマの配列。
      filtered_talk_themes: [], // 選択したカテゴリーのトークテーマの配列。
      current_page: 1, // トークテーマ一覧の現在ページ。
      par_page: 10, // 1ページにつき、表示されるトークテーマの数。
    };
  },
  watch: {
    // 選択したカテゴリーが変わるごとに、ルーレットの内容と取得するカテゴリー名を変更する。
    category_id: async function () {
      await this.setTalkThemesByCategory();
      this.sortTalkThemesByPopularity;
      this.current_page = 1;
    },
  },
  computed: {
    // トークテーマをいいね数が多い順に並び替える。
    sortTalkThemesByPopularity() {
      this.filtered_talk_themes.sort((a, b) => {
        return b.likes.length - a.likes.length;
      });
    },

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

    // 特定のカテゴリーを削除する。
    deleteCategory() {
      if (
        confirm(
          `「${this.category_name}」カテゴリーを削除してもよろしいですか?`
        )
      )
        axios.delete(`/api/v1/categories/${this.category_id}`).then(() => {
          this.categoryDefault();
        });
    },

    // 特定のトークテーマを削除する。
    deleteTalkTheme(delete_id) {
      if (
        confirm(
          `「${this.talkThemeContent(delete_id)}?」を削除してもよろしいですか?`
        )
      )
        axios.delete(`/api/v1/talk_themes/${delete_id}`).then(() => {
          this.filtered_talk_themes = this.filtered_talk_themes.filter(
            (talk_theme) => talk_theme.id != delete_id
          );
        });
    },

    // 削除したいトークテーマの内容を取得する。
    talkThemeContent(delete_id) {
      const filtered_date = this.talk_themes.find(
        (talk_theme) => talk_theme.id == delete_id
      );
      return filtered_date.content;
    },

    // 選択したカテゴリーのルーレット内容を配列にする。
    async setTalkThemesByCategory() {
      this.fetchCategories();

      const selected_category = this.categories.find(
        (category) => category.id == this.category_id
      );

      // 選択したカテゴリーのカテゴリー名とトークテーマをdataプロパティに代入する。
      this.category_name = selected_category.name;
      this.talk_themes = selected_category.talk_themes;

      // 選択したカテゴリーのトークテーマを別のdataプロパティに再代入する。
      this.filtered_talk_themes = this.talk_themes;
    },

    // 検索したトークテーマのデータをdataプロパティに代入する。
    getValue(display_format, filtered_talk_themes) {
      this.filtered_talk_themes = filtered_talk_themes;
      this.current_page = 1;
    },
  },
};
</script>

<style scoped></style>
