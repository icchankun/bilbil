<template>
  <div>
    <div class="mb-3">
      <label for="talkThemeSearchForm" class="form-label"
        >トークテーマ検索</label
      >
      <div class="input-group">
        <input
          type="text"
          class="form-control"
          id="talkThemeSearchForm"
          placeholder="例）歌手 曲"
          v-model="search_query"
        />
        <button
          @click="filteredTalkThemes($event)"
          class="btn btn-primary"
          id="is_filtered"
        >
          <i class="fas fa-search"></i> 検索
        </button>
      </div>
    </div>
    <div
      @click="filteredTalkThemes($event)"
      class="btn btn-secondary me-2 mb-3"
      id=" is_not_filtered"
    >
      トークテーマを全て表示
    </div>
    <div
      @click="filteredTalkThemes($event)"
      class="btn btn-secondary mb-3"
      id="is_liked"
    >
      いいねしたトークテーマを表示
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: {
    category_id: {
      type: Number,
    },
    modelValue: {
      type: Array,
    },
    liked_talk_theme_ids: {
      type: Array,
    },
  },
  data() {
    return {
      search_query: "", //検索クエリ
      filtered_talk_themes: [], // 選択したカテゴリーのトークテーマの配列。
    };
  },
  emits: [
    "getFilteredTalkThemes",
    'update:modelValue',
  ],
  computed: {
    talk_themes: {
      get() {
        return this.modelValue
      },
      set(talk_themes) {
        this.$emit('update:modelValue', talk_themes)
      }
    }
  },
  methods: {
    // 検索フォームに入力した文字列をもとにトークテーマを検索する。
    async filteredTalkThemes(e) {
      await this.UpdateTalkThemesLikes();

      const id = e.target.id;
      switch (id) {
        case "is_filtered":
          this.filtered_talk_themes = this.talk_themes.filter((talk_theme) => {
            return this.search_query
              .split(/\s+/)
              .map((query) => talk_theme.content.indexOf(query) > -1)
              .some((result) => result === true);
          });
          break;
        case "is_liked":
          this.filtered_talk_themes = this.talk_themes.filter((talk_theme) =>
            this.liked_talk_theme_ids.includes(talk_theme.id)
          );
          break;
        default:
          this.filtered_talk_themes = this.talk_themes;
      }

      this.$emit("getFilteredTalkThemes", this.filtered_talk_themes);
    },

    async UpdateTalkThemesLikes() {
      // 全カテゴリーのデータを取得する。
      const response = await axios.get("/api/v1/categories");
      const categories = response.data;

      // 選択したカテゴリーのデータを変数に代入する。
      const selected_category = categories.find(
        (category) => category.id == this.category_id
      );

      // 選択したカテゴリーのトークテーマをdataプロパティに代入する。
      this.talk_themes = selected_category.talk_themes;

      // 選択したカテゴリーのトークテーマを別のdataプロパティに再代入する。
      this.filtered_talk_themes = this.talk_themes;
    },
  },
};
</script>

<style scoped></style>
