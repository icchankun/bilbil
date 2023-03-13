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
        <button @click="filteredTalkThemes()" class="btn btn-primary">
          <i class="fas fa-search"></i> 検索
        </button>
      </div>
    </div>
    <div>
      <select v-model="display_format">
        <option value="all">全てのトークテーマを表示</option>
        <option value="is_liked">いいねしたトークテーマを表示</option>
      </select>
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
      search_query: "", // 検索クエリ
      display_format: "all", // トークテーマ一覧の表示形式
      filtered_talk_themes: [], // 選択したカテゴリーのトークテーマの配列。
    };
  },
  emits: ["getValue", "update:modelValue"],
  watch: {
    display_format: async function () {
      await this.UpdateTalkThemesLikes();

      switch (this.display_format) {
        case "is_liked":
          this.filtered_talk_themes = this.talk_themes.filter((talk_theme) =>
            this.liked_talk_theme_ids.includes(talk_theme.id)
          );
          break;
        default:
          this.filtered_talk_themes = this.talk_themes;
      }

      this.$emit("getValue", this.display_format, this.filtered_talk_themes);
    },

    category_id: function() {
      this.search_query = "";
    },
  },
  computed: {
    talk_themes: {
      get() {
        return this.modelValue;
      },
      set(newVal) {
        this.$emit("update:modelValue", newVal);
      },
    },
  },
  methods: {
    // 検索フォームに入力した文字列をもとにトークテーマを検索する。
    async filteredTalkThemes() {
      await this.UpdateTalkThemesLikes();

      switch (this.display_format) {
        case "is_liked":
          this.filtered_talk_themes = this.talk_themes.filter((talk_theme) =>
            this.liked_talk_theme_ids.includes(talk_theme.id)
          );
          break;
        default:
          this.filtered_talk_themes = this.talk_themes;
      }

      this.filtered_talk_themes = this.filtered_talk_themes.filter((talk_theme) => {
        return this.search_query
          .split(/\s+/)
          .map((query) => talk_theme.content.indexOf(query) > -1)
          .some((result) => result === true);
      });

      this.$emit("getValue", this.display_format, this.filtered_talk_themes);
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

      // 表示されていたトークテーマの更新データを代入する。
      const filtered_talk_themes_ids = this.filtered_talk_themes.map(
        (talk_theme) => talk_theme.id
      );
      this.filtered_talk_themes = this.talk_themes.filter((talk_theme) =>
        filtered_talk_themes_ids.includes(talk_theme.id)
      );
    },
  },
};
</script>

<style scoped></style>
