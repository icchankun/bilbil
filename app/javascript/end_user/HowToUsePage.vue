<template>
  <Header>G U I D E</Header>
  <main class="container my-5">
    <div class="row">
      <div class="col-12 col-lg-7 mx-auto">
        <head-line>TALK THEME</head-line>
        <div class="description d-flex flex-column mx-auto mb-5">
          <div class="mb-3">
            <div class="mb-2">
              1.お好きなトークテーマカテゴリーを選択します。
              <div class="fw-normal">※選択したボタンは色が変わります。</div>
            </div>
            <div class="d-flex flex-wrap">
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
          </div>
          <div class="mb-3">
            <div class="mb-2">
              2. ルーレットの右にあるボタンを押します。
              <div class="fw-normal">※トークテーマルーレットのボタンは下にあります。</div>
            </div>
            <div class="row">
              <div class="d-flex col-12 col-lg-6 mb-3 fw-normal">
                <div class="stop_btn">
                  <i class="fas fa-sync-alt"></i>
                </div>
                <span class="p-2">スタートボタン</span>
              </div>
              <div class="d-flex col-12 col-lg-6 mb-3 fw-normal">
                <div class="start_btn">
                  <i class="fas fa-stop-circle"></i>
                </div>
                <span class="p-2">ストップボタン</span>
              </div>
            </div>
          </div>
          <div>3. 止まったテーマでトークをします。</div>
        </div>
        <head-line>TALK SUPPORT</head-line>
        <div class="description d-flex flex-column mx-auto mb-5">
          <div class="mb-3">
            <div class="mb-2">
              1. トーク人数のボタンを押します。
              <div class="fw-normal">※選択したボタンは色が変わります。</div>
            </div>
            <div class="d-flex flex-wrap justify-content-start">
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
          </div>
          <div class="mb-3">
            2. 番号指定ルーレットの指示に従って、各参加者に番号を振ります。
          </div>
          <div class="mb-3">
            3. 使いたいトークサポートルーレットを回します。
          </div>
          <div class="mb-3">
            <div class="mb-2">
              <div>トーク順番ルーレット</div>
              <div class="fw-normal">
                番号指定ルーレットで決めた番号をもとにトーク順番を決定します。
              </div>
            </div>
            <div>
              <div>司会者ルーレット</div>
              <div class="fw-normal">
                司会者を決めるためのルーレットです。<br />
                司会者とは、なっていますが、発表者を決める際などにも使用できます。<br />
                ※2人の時は、司会者ルーレットは表示されません。
              </div>
            </div>
          </div>
          <div>4. 止まった指示に従って、トークをします。</div>
        </div>
        <div class="text-center mb-3">
          <router-link class="py-1" to="/content"
            >トークテーマの確認はこちらから。</router-link
          >
        </div>
        <root-path-button>ルーレットページに戻る</root-path-button>
      </div>
    </div>
  </main>
  <end-user-footer>
    トークテーマルーレットだけでも利用できますが、トークサポートルーレットも<br />
    合わせて利用していただくことをおすすめします。
  </end-user-footer>
</template>

<script>
import axios from "axios";

import Header from "../components/Header.vue";
import HeadLine from "../components/Headline.vue";
import RootPathButton from "../components/RootPathButton.vue";
import EndUserFooter from "../components/EndUserFooter.vue";

export default {
  components: {
    Header,
    HeadLine,
    RootPathButton,
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
.start_btn {
  background-color: #0070f3;
  width: 40px;
  color: #fff;
  display: flex;
  justify-content: center;
  align-items: center;
}
.stop_btn {
  background-color: #ff5858;
  color: #fff;
  width: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
