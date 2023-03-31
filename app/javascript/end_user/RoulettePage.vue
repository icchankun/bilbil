<template>
  <Header>B I L B I L</Header>
  <main class="container my-5">
    <div class="row mx-2">
      <div class="col-md-7 mx-auto">
        <!-- ページ遷移リンク -->
        <div class="mb-3">
          <div class="mb-2">
            <router-link class="py-1" to="/guide"
              >ご利用ガイドはこちらから。</router-link
            >
          </div>
          <div>
            <router-link class="py-1" to="/content"
              >トークテーマの確認はこちらから。</router-link
            >
          </div>
        </div>
        <!-- /ページ遷移リンク -->
        <!-- トークテーマルーレット -->
        <div class="mb-5">
          <head-line>TALK THEME</head-line>
          <talk-theme-roulette></talk-theme-roulette>
        </div>
        <!-- /トークテーマルーレット -->
        <!-- トークサポート -->
        <div class="mb-5">
          <head-line>TALK SUPPORT</head-line>
          <form @submit.prevent="addName">
            <label>Name:</label>
            <input type="text" v-model="new_name" />
            <br />
            <button type="submit">Add Name</button>
          </form>

          <ul>
            <li v-for="(participant, index) in participants">
              {{ participant.name }}
              <button @click="deleteName(index)">Delete</button>
            </li>
          </ul>
        </div>
        <!-- /トークサポート -->
      </div>
    </div>
  </main>
  <end-user-footer>
    bilbil（ビルビル）はトークで困らないためのトークサポートアプリです。
    オンライン・オフラインを選ばず、利用することができます。
  </end-user-footer>
</template>

<script>
import Header from "../components/Header.vue";
import HeadLine from "../components/Headline.vue";
import TalkThemeRoulette from "../components/TalkThemeRoulette.vue";
import EndUserFooter from "../components/EndUserFooter.vue";

export default {
  components: {
    Header,
    HeadLine,
    TalkThemeRoulette,
    EndUserFooter,
  },
  data() {
    return {
      new_name: "", // フォームに入力された名前。
      participants: JSON.parse(localStorage.getItem("participants")) || [], // トーク参加者の名前の配列。
    };
  },
  methods: {
    addName() {
      // 新しい名前を追加する。
      this.participants.push({ name: this.new_name });

      // フォームを空にする。
      this.new_name = "";

      // ローカルストレージにデータを保存する
      localStorage.setItem("participants", JSON.stringify(this.participants));
    },
    deleteName(index) {
      // 名前を削除する
      this.participants.splice(index, 1);

      // ローカルストレージにデータを保存する
      localStorage.setItem("participants", JSON.stringify(this.participants));
    },
  },
};
</script>

<style>
.roulette {
  border: 1px solid #000;
  padding: 0.5rem;
  font-size: 14px;
  font-weight: bold;
  text-align: center;
}

.start_btn {
  background-color: #0070f3;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
}

.stop_btn {
  background-color: #ff5858;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
}

/***************************
  メディアクエリ 768px以下
***************************/
@media (min-width: 768px) {
  .roulette {
    font-size: 1rem;
  }
}
</style>
