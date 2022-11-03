<template>
  <Header>B I L B I L</Header>
  <main class="container my-5">
    <div class="row mb-5">
      <div class="col-12 col-sm-6 mx-auto">
        <div class="mb-3">
            <router-link class="py-1" to="/content"
              >トークテーマの確認はこちらから。</router-link
            >
        </div>
        <head-line>TALK THEME</head-line>
        <div class="fs-5 mb-3">カテゴリーを選んでください</div>
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
              class="btn btn-outline-secondary"
              :for="[`category` + index]"
              >{{ category.name }}</label
            >
          </div>
        </div>
        <div class="fs-5">
          {{ category_name }}トーク
        </div>
        <div class="talk_theme_roulette p-5 mb-3 fs-5 fw-bold">
          <span v-if="this.talk_theme != undefined">
            {{ talk_theme.content }} ?
          </span>
          <span v-else>トークはありません。</span>
        </div>
        <div class="text-center">
          <div
            class="d-inline-block text-white"
            @click="
              roulette();
              active();
            "
          >
            <div class="start_btn p-3" v-if="this.is_active">
              <i class="fa-solid fa-circle-stop me-2"></i>
              <span>ストップ</span>
            </div>
            <div class="stop_btn p-3" v-else>
              <i class="fa-solid fa-arrows-rotate me-2"></i>
              <span>スタート</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-12 col-sm-6 mx-auto">
        <div class="mb-3">
          <head-line>TALK SUPPORT</head-line>
        </div>
      </div>
    </div>
  </main>
  <Footer></Footer>
</template>

<script>
import axios from "axios";

import Header from "../components/Header.vue";
import HeadLine from "../components/Headline.vue";
import Footer from "../components/Footer.vue";

export default {
  components: {
    Header,
    HeadLine,
    Footer,
  },
  data() {
    return {
      categories: {},
      category_id: "",
      talk_theme: {},
      is_active: false,
    };
  },
  computed: {
    category_name() {
      const category = this.categories.find(category => category.id == this.category_id);
      return category.name;
    },
  },
  created() {
    axios
      .get("/api/v1/categories")
      .then((response) => {
        this.categories = response.data;
        this.category_id = this.categories[0].id;
      })
      .then(() => {
        this.talkThemes();
      });
  },
  watch: {
    category_id: function () {
      this.talkThemes();
    },
  },
  methods: {
    talkThemes: function () {
      let talk_themes = [];
      this.categories.forEach((category) => {
        if (category.id == this.category_id) {
          talk_themes = category.talk_themes;
          this.talk_theme =
            talk_themes[Math.floor(Math.random() * talk_themes.length)];
        }
      });
    },
    active() {
      this.is_active = !this.is_active;
    },
    roulette: function () {
      let roulette = setInterval(() => {
        if (this.is_active) {
          this.talkThemes();
        } else {
          clearInterval(roulette);
        }
      }, 100);
    },
  },
};
</script>

<style scoped>
.btn-outline-secondary {
  width: 80px;
  border-radius: 40px;
}

.talk_theme_roulette {
  display: flex;
  justify-content: center;
  align-items: center;
  border: 1px solid #000;
  border-radius: 5px;
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
