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
          :talk_themes="talk_themes"
          @separateTalkThemesByCategory="separateTalkThemesByCategory"
          @getFilteredTalkThemes="getFilteredTalkThemes"
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
              v-if="filtered_talk_themes.length == 0"
              class="btn btn-danger btn-sm"
              @click="deleteCategory()"
              >カテゴリーを削除</a
            >
            <span v-else
              >トークテーマ数: {{ filtered_talk_themes.length }}</span
            >
          </div>
        </div>
        <ol class="list">
          <!-- トークテーマが存在する場合 -->
          <div
            v-if="filtered_talk_themes.length != 0"
            v-for="(talk_theme, index) in filtered_talk_themes"
            :key="talk_theme.id"
            class="row mb-2"
          >
            <div class="col-12 col-sm-6">
              <li>
                <router-link
                  :to="{
                    name: 'TalkThemeEditPage',
                    params: { id: talk_theme.id },
                  }"
                  ><span class="fw-bold"
                    >{{ talk_theme.content }}?</span
                  ></router-link
                >
              </li>
            </div>
            <div class="col-12 col-sm-6">
              <a
                class="btn btn-danger btn-sm me-2"
                @click="deleteTalkTheme(talk_theme.id)"
                >{{ index + 1 }}を削除</a
              >
              <span> いいね数: {{ talk_theme.likes.length }} </span>
            </div>
          </div>
          <!-- /トークテーマが存在する場合 -->
          <!-- トークテーマが存在しない場合 -->
          <div v-else class="talk_themes-field">トークテーマはありません。</div>
          <!-- /トークテーマが存在しない場合 -->
        </ol>
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
import AdminFooter from "../components/AdminFooter.vue";

export default {
  components: {
    Header,
    TalkThemeSearchForm,
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
    };
  },
  watch: {
    // 選択したカテゴリーが変わるごとに、ルーレットの内容と取得するカテゴリー名を変更する。
    category_id: async function () {
      await this.separateTalkThemesByCategory();
      this.sortTalkThemesByPopularity;
    },
  },
  computed: {
    // トークテーマをいいね数が多い順に並び替える。
    sortTalkThemesByPopularity() {
      this.filtered_talk_themes.sort((a, b) => {
        return b.likes.length - a.likes.length;
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
    async separateTalkThemesByCategory() {
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
    getFilteredTalkThemes(value) {
      this.filtered_talk_themes = value;
    },
  },
};
</script>

<style scoped>
.talk_themes-field {
  font-size: 14px;
  font-weight: bold;
  text-align: center;
  padding: 0 35px 0 0;
}
</style>
