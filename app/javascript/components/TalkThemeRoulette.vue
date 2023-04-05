<template>
  <div class="mb-1">カテゴリーを選んでください。</div>
  <!-- カテゴリー選択ボタン -->
  <div class="d-flex flex-wrap mb-3">
    <div
      class="me-2"
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
  <!-- ルーレット内容変更ボタン -->
  <div class="mb-3">
    <div class="mb-1">いいねしたトークテーマのみをルーレットで表示する。</div>
    <div class="form-switch">
      <input
        type="checkbox"
        class="form-check-input"
        role="switch"
        v-model="checked"
      />
    </div>
  </div>
  <!-- /ルーレット内容変更ボタン -->
  <!-- ルーレット表示部分 -->
  <div class="mb-1">{{ this.category_name }}トーク</div>
  <div class="talk_theme_roulette mb-3">
    <span class="m-4" v-if="this.talk_theme != undefined">
      {{ talk_theme }} ?
    </span>
    <span v-else>トークはありません。</span>
  </div>
  <!-- /ルーレット表示部分 -->
  <!-- ルーレットボタン -->
  <div class="text-center">
    <div
      class="d-inline-block text-white"
      @click="
        roulette();
        active();
      "
    >
      <div class="stop_btn p-3" v-if="this.is_active">
        <i class="fas fa-stop-circle me-2"></i>
        <span>ストップ</span>
      </div>
      <div class="start_btn p-3" v-else>
        <i class="fas fa-sync-alt me-2"></i>
        <span>スタート</span>
      </div>
    </div>
  </div>
  <!-- /ルーレットボタン -->
</template>

<script>
import axios from "axios";

export default {
  created() {
    this.categoryDefault();
    this.fetchLikedTalkThemes();
  },
  data() {
    return {
      categories: [], // 全カテゴリーのデータの配列。
      category_id: 0, // 選択されたカテゴリーのid。
      category_name: "", // 選択されたカテゴリーのカテゴリー名。
      talk_theme: "", // ルーレットに表示されるトークテーマ。
      talk_themes: [], // 選択されたカテゴリーのトークテーマ。
      liked_talk_theme_ids: [], // いいねをしたトークテーマのidの配列。
      liked_talk_themes: [], // いいねをしたトークテーマの配列。
      is_active: false, // ルーレットボタンの切り替え。
      checked: false, // ルーレットで表示されるトークテーマをいいねしたものだけにするか全てのものにするかの切り替え。
    };
  },
  watch: {
    // 選択したカテゴリーが変わるごとに、ルーレットの内容と取得するカテゴリー名を変更する。
    category_id: function () {
      this.is_active = false;
      this.setTalkThemes();
      this.setLikedTalkThemes();
      this.displayTalkTheme();
    },
    checked: function () {
      this.displayTalkTheme();
    },
  },
  methods: {
    async categoryDefault() {
      const response = await axios.get("/api/v1/categories");
      this.categories = response.data;

      // 選択されたカテゴリーの初期値をカテゴリーデータの先頭にする。
      this.category_id = this.categories[0].id;
    },

    setTalkThemes() {
      // 選択したカテゴリーのルーレット内容を配列にする。
      const selected_category = this.categories.find(
        (category) => category.id == this.category_id
      );

      // 選択したカテゴリーのカテゴリー名、トークテーマを取得する。
      this.category_name = selected_category.name;
      this.talk_themes = selected_category.talk_themes;

      // トークテーマをいいね数が多い順に並び替える。
      this.talk_themes.sort((a, b) => {
        return b.likes.length - a.likes.length;
      });
    },

    displayTalkTheme() {
      switch (this.checked) {
        case true:
          // liked_talk_themesのlengthが0であれば、dataのliked_talk_themeにundefinedを代入し、このメソッドを終了する。
          if (this.liked_talk_themes.length == 0) {
            this.talk_theme = undefined;
            return;
          }

          // dataのtalk_themeにランダムでいいねされたトークテーマのデータを代入する。
          this.talk_theme =
            this.liked_talk_themes[
              Math.floor(Math.random() * this.liked_talk_themes.length)
            ].content;
          break;
        default:
          // talk_themesのlengthが0であれば、dataのtalk_themeにundefinedを代入し、このメソッドを終了する。
          if (this.talk_themes.length == 0) {
            this.talk_theme = undefined;
            return;
          }

          // 各カテゴリーの人気トークテーマの10番目までを取得する。
          const up_to_the_tenth = {};
          const RATIO = 30;

          for (const index in this.talk_themes) {
            if (index < 10) {
              // 「"トークテーマ": 30」をup_to_the_tenthに格納する。
              up_to_the_tenth[this.talk_themes[index].content] = RATIO;
            } else {
              break;
            }
          }

          // resultにランダムでトークテーマを代入する。
          let result =
            this.talk_themes[
              Math.floor(Math.random() * this.talk_themes.length)
            ].content;

          for (const talk_theme in up_to_the_tenth) {
            // ランダムに0~100をrandに代入する。
            const rand = Math.floor(Math.random() * 100);

            // もしrandの数値がトークテーマに付与された数値以下だったら、そのトークテーマをresultに代入する。
            if (rand <= RATIO) {
              result = talk_theme;
              break;
            }
          }

          // dataのtalk_themeにresultを代入する。
          this.talk_theme = result;
      }
    },

    // ルーレットのボタンを切り替える。
    active() {
      this.is_active = !this.is_active;
    },

    // ルーレットの内容の配列からランダムで1つデータを表示させることを0.1秒ごとに繰り返す。
    roulette() {
      let roulette = setInterval(() => {
        if (this.is_active) {
          this.displayTalkTheme();
        } else {
          // 0.1秒ごとに1つデータを表示させることを止める。
          clearInterval(roulette);
        }
      }, 100);
    },

    // 接続しているipアドレスをipカラムに保存しているいいねレコードのトークテーマidカラムの値を配列にし、取得する。
    fetchLikedTalkThemes() {
      axios.get("/api/v1/like/ip").then((response) => {
        this.liked_talk_theme_ids = response.data;
        this.setLikedTalkThemes();
      });
    },

    // いいねされたトークテーマのidの配列をもとにいいねされたトークテーマの配列を取得する。。
    setLikedTalkThemes() {
      this.liked_talk_themes = this.talk_themes.filter((talk_theme) =>
        this.liked_talk_theme_ids.includes(talk_theme.id)
      );
    },
  },
};
</script>

<style scoped>
.talk_theme_roulette {
  display: flex;
  justify-content: center;
  align-items: center;
  border: 1px solid #000;
  border-radius: 5px;
  font-weight: bold;
  font-size: 1.25rem;
  height: 200px;
}

.form-check-input {
  height: 1.5em;
  width: 3em;
}
</style>
