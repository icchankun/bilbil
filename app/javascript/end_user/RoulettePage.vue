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
            <div class="mb-1">
              トーク参加者の名前を下のフォームから2人以上追加することで、トークの司会者・話し手/順番を決定する機能を使えるようになります。
            </div>
            <div class="input-group mb-3">
              <input
                type="text"
                class="form-control"
                placeholder="例）太郎"
                v-model="new_name"
              />
              <br />
              <button type="submit" class="btn btn-primary">追加</button>
            </div>
          </form>
          <one-person-display :participants="participants"></one-person-display>
          <talk-order-shuffle v-model="participants"></talk-order-shuffle>
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
import TalkOrderShuffle from "../components/TalkOrderShuffle.vue";
import OnePersonDisplay from "../components/OnePersonDisplay.vue";
import EndUserFooter from "../components/EndUserFooter.vue";

export default {
  components: {
    Header,
    HeadLine,
    TalkThemeRoulette,
    TalkOrderShuffle,
    OnePersonDisplay,
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
  },
};
</script>

<style lang="scss">
.roulette {
  border: 1px solid #000;
  padding: 0.5rem;
  font-size: 14px;
  font-weight: bold;
  text-align: center;
}

.start_btn,
.stop_btn {
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 10px;
  cursor: pointer;
}

.start_btn {
  background-color: #ff5858;
}

.stop_btn {
  background-color: #0070f3;
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
