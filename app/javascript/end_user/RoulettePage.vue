<template>
  <div v-if="showContent" id="overlay">
    <div id="content">
      <p>これがモーダルウィンドウです。</p>
      <p><button @click="closeModal">close</button></p>
    </div>
  </div>
  <Header>B I L B I L</Header>
  <main class="container my-5">
    <div class="row">
      <div class="col-12 col-sm-7 mx-auto">
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
        <div class="px-1 mb-5">
          <head-line>TALK THEME</head-line>
          <talk-theme-roulette></talk-theme-roulette>
        </div>
        <div class="px-1">
          <head-line>TALK SUPPORT</head-line>
          <div class="fs-5 mb-2">トーク人数を選んでください。</div>
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
          <number-assignment-roulette @openModal="openModal"></number-assignment-roulette>
          <div class="row">
            <div class="col-7">
              <talk-order-roulette
                :number_of_people="number_of_people"
                @openModal="openModal"
              ></talk-order-roulette>
            </div>
            <div class="col-5">
              <host-roulette
                :number_of_people="number_of_people"
                @openModal="openModal"
              ></host-roulette>
            </div>
          </div>
        </div>
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
import NumberAssignmentRoulette from "../components/NumberAssignmentRoulette.vue";
import TalkOrderRoulette from "../components/TalkOrderRoulette.vue";
import HostRoulette from "../components/HostRoulette.vue";
import EndUserFooter from "../components/EndUserFooter.vue";

export default {
  components: {
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
      number_of_people: 2,
      showContent: false,
    };
  },
  methods: {
    openModal() {
      this.showContent = true;
    },
    closeModal() {
      this.showContent = false;
    },
  },
};
</script>

<style>
#overlay {
  z-index: 1;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
}
#content {
  z-index: 2;
  width: 50%;
  padding: 1em;
  background: #fff;
}
.number_btn {
  border-radius: 10px;
  font-weight: bold;
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
</style>
