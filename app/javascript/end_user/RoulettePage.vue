<template>
  <Header>B I L B I L</Header>
  <main class="container my-5">
    <modal-window
      :show_content="show_content"
      :roulette_type="roulette_type"
      @closeModal="closeModal"
    ></modal-window>
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
        <!-- トークサポートルーレット -->
        <div class="mb-5">
          <head-line>TALK SUPPORT</head-line>
          <div class="mb-1">トーク人数を選んでください。</div>
          <div class="d-flex flex-wrap mb-4">
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
          <!-- はてなボタン説明 -->
          <div class="mb-3">
            はてなボタンを押すと、各ルーレットの使い方を見ることができます。
          </div>
          <!-- /はてなボタン説明 -->
          <!-- 番号指定ルーレット -->
          <number-assignment-roulette
            @openModal="openModal"
          ></number-assignment-roulette>
          <!-- /番号指定ルーレット -->
          <div class="row">
            <!-- トーク順番ルーレット -->
            <div class="col-12 col-lg-5 mb-3 me-lg-auto mb-lg-0">
              <talk-order-roulette
                :number_of_people="number_of_people"
                @openModal="openModal"
              ></talk-order-roulette>
            </div>
            <!-- /トーク順番ルーレット -->
            <!-- 司会者・話し手指定ルーレット -->
            <div class="col-12 col-lg-6">
              <host-roulette
                :number_of_people="number_of_people"
                @openModal="openModal"
              ></host-roulette>
            </div>
            <!-- /司会者・話し手指定ルーレット -->
          </div>
        </div>
        <!-- /トークサポートルーレット -->
      </div>
    </div>
  </main>
  <end-user-footer>
    bilbil（ビルビル）はトークで困らないためのトークサポートアプリです。
    オンライン・オフラインを選ばず、利用することができます。
  </end-user-footer>
</template>

<script>
import ModalWindow from "../components/ModalWindow.vue";
import Header from "../components/Header.vue";
import HeadLine from "../components/Headline.vue";
import TalkThemeRoulette from "../components/TalkThemeRoulette.vue";
import NumberAssignmentRoulette from "../components/NumberAssignmentRoulette.vue";
import TalkOrderRoulette from "../components/TalkOrderRoulette.vue";
import HostRoulette from "../components/HostRoulette.vue";
import EndUserFooter from "../components/EndUserFooter.vue";

export default {
  components: {
    ModalWindow,
    Header,
    HeadLine,
    TalkThemeRoulette,
    NumberAssignmentRoulette,
    TalkOrderRoulette,
    HostRoulette,
    EndUserFooter,
  },
  data() {
    return {
      number_of_people: 2, // 選択されているトーク人数（デフォルトは2人）。
      show_content: false, // モーダルの表示の有無。
      roulette_type: "", // ルーレットの種類。
    };
  },
  methods: {
    // どのルーレットかを判断し、そのルーレットの説明が書かれたモーダルウィンドウを表示する。
    openModal(roulette_type) {
      this.show_content = true;
      this.roulette_type = roulette_type;
    },
    // モーダルウィンドウを閉じる。
    closeModal() {
      this.show_content = false;
    },
  },
};
</script>

<style>
.modal_btn {
  padding: 5px 10px;
  border: solid 1px #6c757d;
  cursor: pointer;
}

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
}

.stop_btn {
  background-color: #ff5858;
  display: flex;
  justify-content: center;
  align-items: center;
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
