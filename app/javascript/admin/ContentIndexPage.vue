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
          <div v-if="talk_themes.length == 0" class="col-12 col-sm-6">
            <a
              class="btn btn-danger btn-sm"
              @click="deleteCategory(category_id)"
              >カテゴリーを削除</a
            >
          </div>
        </div>
        <ol class="list">
          <!-- トークテーマが存在する場合 -->
          <div
            v-if="talk_themes.length != 0"
            v-for="(talk_theme, index) in talk_themes"
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
import AdminFooter from "../components/AdminFooter.vue";

export default {
  components: {
    Header,
    AdminFooter,
  },
  data() {
    return {
      categories: [], // 全カテゴリーのデータの配列。
      talk_themes: [], // 全トークテーマのデータの配列。
      category_id: 0, // 選択されたカテゴリーのid。
      category_name: "", // 選択されたカテゴリーのカテゴリー名
    };
  },
  watch: {
    // 選択したカテゴリーが変わるごとに、ルーレットの内容と取得するカテゴリー名を変更する。
    category_id: function () {
      this.talkThemes();
    },
  },
  created() {
    // 全カテゴリーのデータを取得し、いいね数が多い順にトークテーマを並び替える。
    axios.get("/api/v1/categories").then((response) => {
      this.categories = response.data;
      this.category_id = this.categories[0].id;
      this.sortedTalkThemesByLikes;
    });
  },
  computed: {
    // トークテーマをいいね数が多い順に並び替える。
    sortedTalkThemesByLikes() {
      this.categories.forEach((category) => {
        category.talk_themes.sort((a, b) => {
          return b.likes.length - a.likes.length;
        });
      });
    },
  },
  methods: {
    // 特定のカテゴリーを削除する。
    deleteCategory(delete_id) {
      if (
        confirm(`「${this.categoryName(delete_id)}」カテゴリーを削除してもよろしいですか?`)
      )
        axios.delete(`/api/v1/categories/${delete_id}`).then(() => {
          this.updateContents();
          this.category_id = this.categories[0].id;
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
          this.updateContents();
        });
    },

    // 削除したいカテゴリーのカテゴリー名を取得する。
    categoryName(delete_id) {
      const filterDate = this.categories.filter(
        (category) => category.id === delete_id
      );
      return filterDate[0].name;
    },

    // 削除したいトークテーマの内容を取得する。
    talkThemeContent(delete_id) {
      const filterDate = this.talk_themes.filter(
        (talk_theme) => talk_theme.id === delete_id
      );
      return filterDate[0].content;
    },

    // 最新の全カテゴリーのデータを取得する。
    updateContents() {
      axios.get("/api/v1/categories").then((response) => {
        this.categories = response.data;
        this.talkThemes();
      });
    },

    // 選択したカテゴリーのルーレット内容を配列にする。
    talkThemes() {
      const selected_category = this.categories.find(
        (category) => category.id == this.category_id
      );
      this.category_name = selected_category.name;
      this.talk_themes = selected_category.talk_themes;
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
