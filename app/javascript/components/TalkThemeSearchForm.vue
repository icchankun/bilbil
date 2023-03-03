<template>
  <div class="mb-3">
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
      class="btn btn-secondary"
      id=" is_not_filtered"
    >
    トークテーマを全て表示
    </div>
  </div>
</template>

<script>
export default {
  props: {
    talk_themes: {
      type: Array
    },
  },
  data() {
    return {
      search_query: "",
      filtered_talk_themes: [], // 選択したカテゴリーのトークテーマの配列。
    };
  },
  emits: ["separateTalkThemesByCategory", "sortTalkThemes", "getFilteredTalkThemes"],
  methods: {
    // 検索フォームに入力した文字列をもとにトークテーマを検索する。
    filteredTalkThemes(e) {
      this.$emit("separateTalkThemesByCategory");

      if (e.target.id == "is_filtered") {
        this.filtered_talk_themes = this.talk_themes.filter((talk_theme) => {
          return this.search_query
            .split(/\s+/)
            .map((query) => talk_theme.content.indexOf(query) > -1)
            .some((result) => result === true);
        });
      } else {
        this.filtered_talk_themes = this.talk_themes;
      }

      this.$emit("sortTalkThemes");
      this.$emit("getFilteredTalkThemes", this.filtered_talk_themes);
    },
  },
};
</script>

<style scoped></style>
