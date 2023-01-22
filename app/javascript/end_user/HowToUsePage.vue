<template>
  <Header>G U I D E</Header>
  <main class="container my-5">
    <div class="row mx-2">
      <div class="col-lg-7 mx-auto">
        <!-- トークテーマルーレットの使用方法説明 -->
        <head-line>TALK THEME</head-line>
        <ol class="fw-bold mb-5">
          <li class="mb-1">
            お好きなトークテーマのカテゴリーを選択します。
            <div class="fw-normal">※選択したボタンは色が変わります。</div>
          </li>
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
          <li>
            ルーレットの下に配置したボタンでルーレットをスタート・ストップさせ、
            トークテーマを決定し、会話を始めます。
          </li>
        </ol>
        <!-- /トークテーマルーレットの使用方法説明 -->
        <!-- トークサポートルーレットの使用方法説明 -->
        <head-line>TALK SUPPORT</head-line>
        <ol class="fw-bold mb-5">
          <li class="mb-3">
            トーク人数を選択します。
            <div class="fw-normal">※選択したボタンは色が変わります。</div>
          </li>
          <div class="d-flex flex-wrap mb-3">
            <div class="number_btn-wrapper" v-for="n in 9" :key="n">
              <input
                type="radio"
                class="btn-check"
                :id="n + 1"
                :value="n + 1"
                v-model="number_of_people"
              />
              <label
                class="btn btn-outline-secondary number_btn"
                :for="n + 1"
                >{{ n + 1 }}</label
              >
            </div>
          </div>
          <!-- /トーク人数選択ボタン -->
          <li class="mb-3">
            番号指定/トーク順番/司会者・話し手指定ルーレットは右に配置したボタンでルーレットをスタート・ストップさせます。
          </li>
          <li>
            トーク順番ルーレットの指示と番号指定ルーレットで決めた番号をもとにトークの順番を決めます。<br />
            <br />
            また、司会者・話し手指定ルーレットにより、司会者や話し手を番号指定ルーレットで決めた番号をもとに指定することができます。
          </li>
        </ol>
        <!-- /トークサポートルーレットの使用方法説明 -->
      </div>
      <!-- ページ遷移リンク -->
      <div>
        <div class="text-center mb-3">
          <router-link class="py-1" to="/content"
            >トークテーマの確認はこちらから。</router-link
          >
        </div>
        <roulette-page-back-button></roulette-page-back-button>
      </div>
      <!-- /ページ遷移リンク -->
    </div>
  </main>
  <end-user-footer>
    トークテーマルーレットだけでも利用できますが、トークサポートルーレットも
    合わせて利用していただくことをおすすめします。
  </end-user-footer>
</template>

<script>
import axios from "axios";

import Header from "../components/Header.vue";
import HeadLine from "../components/Headline.vue";
import RoulettePageBackButton from "../components/RoulettePageBackButton.vue";
import EndUserFooter from "../components/EndUserFooter.vue";

export default {
  components: {
    Header,
    HeadLine,
    RoulettePageBackButton,
    EndUserFooter,
  },
  created() {
    // 全カテゴリーのJSONデータを取得し、dataのcategory_idにindexが0のカテゴリーのidを代入する。
    axios.get("/api/v1/categories").then((response) => {
      this.categories = response.data;
      this.category_id = this.categories[0].id;
    });
  },
  data() {
    return {
      categories: [], // 全カテゴリーのデータの配列。
      category_id: "", // 選択されているカテゴリーのid。
      number_of_people: 2, // 選択されているトーク人数（デフォルトは2人）。
    };
  },
};
</script>

<style scoped>
</style>
