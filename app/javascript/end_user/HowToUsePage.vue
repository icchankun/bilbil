<template>
  <Header>G U I D E</Header>
  <main class="container my-5">
    <div class="row">
      <div class="col-12 col-lg-7 mx-auto">
        <head-line>TALK THEME</head-line>
        <ol class="description mx-auto mb-5">
          <li class="mb-3">
            お好きなトークテーマのカテゴリーを選択します。
            <div class="fw-normal">※選択したボタンは色が変わります。</div>
          </li>
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
          <li>
            ルーレットの下に配置したボタンでルーレットをスタート・ストップさせ、<br />
            トークテーマを決定し、会話を始めます。
          </li>
        </ol>
        <head-line>TALK SUPPORT</head-line>
        <ol class="description mx-auto mb-5">
          <li class="mb-3">
            トーク人数を選択します。
            <div class="fw-normal">※選択したボタンは色が変わります。</div>
          </li>
          <div class="d-flex flex-wrap justify-content-start mb-3">
            <div class="me-3" v-for="n in 9" :key="n">
              <input
                type="radio"
                class="btn-check"
                :name="n + 1"
                :id="n + 1"
                :value="n + 1"
                v-model="number_of_people"
                autocomplete="off"
              />
              <label
                class="btn btn-outline-secondary number_btn mb-3"
                :for="n + 1"
                >{{ n + 1 }}</label
              >
            </div>
          </div>
          <li class="mb-3">
            番号指定/トーク順番/司会者・話し手指定ルーレットは右に配置したボタンでルーレットをスタート・ストップさせます。
          </li>
          <li>
            トーク順番ルーレットの指示と番号指定ルーレットで決めた番号をもとにトークの順番を決めます。<br />
            <br />
            また、司会者・話し手指定ルーレットにより、司会者や話し手を番号指定ルーレットで決めた番号をもとに指定することができます。
          </li>
        </ol>
      </div>
      <div class="text-center mb-3">
        <router-link class="py-1" to="/content"
          >トークテーマの確認はこちらから。</router-link
        >
      </div>
      <roulette-page-back-button></roulette-page-back-button>
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
    axios.get("/api/v1/categories").then((response) => {
      this.categories = response.data;
      this.category_id = this.categories[0].id;
    });
  },
  data() {
    return {
      categories: [],
      category_id: "",
      number_of_people: 2,
    };
  },
};
</script>

<style scoped>
.description {
  width: 80%;
  font-weight: bold;
}
.category_btn {
  width: 80px;
  border-radius: 40px;
}

.number_btn {
  border-radius: 10px;
  font-weight: bold;
}
</style>
