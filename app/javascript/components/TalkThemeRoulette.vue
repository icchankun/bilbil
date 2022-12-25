<template>
  <div class="fs-5 mb-3">カテゴリーを選んでください。</div>
  <!-- カテゴリー選択ボタン -->
  <div class="d-flex flex-wrap mb-3">
    <div
      class="me-3"
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
        autocomplete="off"
      />
      <label
        class="btn btn-outline-secondary category_btn"
        :for="[`category` + index]"
        >{{ category.name }}</label
      >
    </div>
  </div>
  <!-- /カテゴリー選択ボタン -->
  <!-- ルーレット表示部分 -->
  <div class="fs-5">{{ this.category_name }}トーク</div>
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
      <div class="start_btn p-3" v-if="this.is_active">
        <i class="fas fa-stop-circle me-2"></i>
        <span>ストップ</span>
      </div>
      <div class="stop_btn p-3" v-else>
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
    // 全カテゴリーのデータを取得し、dataのcategory_idにindexが0のカテゴリーのidを代入する。
    axios.get("/api/v1/categories").then((response) => {
      this.categories = response.data;
      this.category_id = this.categories[0].id;
    });
  },
  data() {
    return {
      categories: [], // 全カテゴリーのデータの配列。
      category_id: "", // 選択されたカテゴリーのid。
      category_name: "", // 選択されたカテゴリーのカテゴリー名。
      talk_theme: {}, // ルーレットに表示されるトークテーマ。
      is_active: false, // ルーレットボタンの切り替え。
    };
  },
  watch: {
    // 選択したカテゴリーが変わるごとに、ルーレットの内容と取得するカテゴリー名を変更する。
    category_id: function () {
      this.talkThemes();
    },
  },
  methods: {
    talkThemes() {
      // 選択したカテゴリーのルーレット内容を配列にする。
      const selected_category = this.categories.find(
        (category) => category.id == this.category_id
      );
      const talk_themes = selected_category.talk_themes;

      // 選択したカテゴリーのカテゴリー名を取得する。
      this.category_name = selected_category.name;

      // 各カテゴリーの人気トークテーマの10番目までを取得する。
      let up_to_the_tenth = {};
      for (const index in talk_themes) {
        if (index < 10) {
          // 「"トークテーマ": 30」をup_to_the_tenthに格納する。
          up_to_the_tenth[talk_themes[index].content] = 30;
        } else {
          break;
        }
      }

      // トークテーマをランダムにresultに代入する。
      let result =
        talk_themes[Math.floor(Math.random() * talk_themes.length)].content;

      for (const talk_theme in up_to_the_tenth) {
        // ランダムに0~100をrandに代入する。
        const rand = Math.floor(Math.random() * 100);
        console.log(rand);

        // もしrandの数値がトークテーマに付与された数値以下だったら、そのトークテーマをresultに代入する。
        if (rand <= up_to_the_tenth[talk_theme]) {
          result = talk_theme;
          break;
        }
      }
      this.talk_theme = result;
    },

    // ルーレットのボタンを切り替える。
    active() {
      this.is_active = !this.is_active;
    },

    // ルーレットの内容の配列からランダムで1つデータを表示させることを0.1秒ごとに繰り返す。
    roulette() {
      let roulette = setInterval(() => {
        if (this.is_active) {
          this.talkThemes();
        } else {
          // 0.1秒ごとに1つデータを表示させることを止める。
          clearInterval(roulette);
        }
      }, 100);
    },
  },
};
</script>

<style scoped>
.category_btn {
  width: 80px;
  border-radius: 40px;
}
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
.start_btn {
  background-color: #0070f3;
  border-radius: 10px;
}
.stop_btn {
  background-color: #ff5858;
  border-radius: 10px;
}
</style>
