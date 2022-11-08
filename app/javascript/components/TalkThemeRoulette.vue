<template>
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
        class="btn btn-outline-secondary category_btn"
        :for="[`category` + index]"
        >{{ category.name }}</label
      >
    </div>
  </div>
  <div class="fs-5">{{ this.category_name }}トーク</div>
  <div class="talk_theme_roulette mb-3 fs-5">
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
        <i class="fas fa-stop-circle me-2"></i>
        <span>ストップ</span>
      </div>
      <div class="stop_btn p-3" v-else>
        <i class="fas fa-sync-alt me-2"></i>
        <span>スタート</span>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  created() {
    axios
      .get("/api/v1/categories")
      .then((response) => {
        this.categories = response.data;
        this.category_id = this.categories[0].id;
      })
      .then(() => {
        this.talkThemes();
        this.getCategoryName();
      });
  },
  data() {
    return {
      categories: [],
      category_id: "",
      category_name:"",
      talk_theme: {},
      is_active: false,
    };
  },
  watch: {
    category_id: function () {
      this.talkThemes();
      this.getCategoryName();
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
    async getCategoryName() {
      const category = await this.category();
      this.category_name = category.name;
    },
    category: function () {
      return new Promise((resolve) => {
        resolve(
          this.categories.find((category) => category.id == this.category_id)
        );
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
