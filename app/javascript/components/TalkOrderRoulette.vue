<template>
  <div class="mb-2">
    <span class="me-2">トーク順番</span>
    <span class="modal_btn" @click="clickEvent">?</span>
  </div>
  <div class="row">
    <!-- ルーレット表示部分 -->
    <div class="col-11 col-lg-10 roulette">
      {{ talk_order }}
    </div>
    <!-- /ルーレット表示部分 -->
    <!-- ルーレットボタン -->
    <div
      class="col-1 col-lg-2 text-white px-0"
      @click="
        roulette();
        active();
      "
    >
      <div class="start_btn h-100" v-if="this.is_active">
        <i class="fas fa-stop-circle"></i>
      </div>
      <div class="stop_btn h-100" v-else>
        <i class="fas fa-sync-alt"></i>
      </div>
    </div>
    <!-- /ルーレットボタン -->
  </div>
</template>

<script>
export default {
  created() {
    this.talkOrder();
  },
  props: {
    number_of_people: "", // トーク人数。
  },
  emits: ["openModal"],
  data() {
    return {
      talk_order: {}, // ルーレットを止めた時に表示する内容。
      is_active: false, // ルーレットのボタンの切り替え。
      roulette_type: "talk_order", // ルーレットの種類。
    };
  },
  watch: {
    // トーク人数が変更するごとにルーレットの内容を変更する。
    number_of_people: function () {
      this.talkOrder();
    },
  },
  methods: {
    // ルーレットの内容の配列を作成し、その配列からランダムで1つデータを表示させる。
    talkOrder() {
      const talk_orders = [];
      if (this.number_of_people == 2) {
        talk_orders.push("1の人から", "2の人から");
      } else {
        for (let n = 1; n <= this.number_of_people; n++) {
          talk_orders.push(
            `${n}の人から右回り`,
            `${n}の人から左回り`,
            `${n}から昇順`,
            `${n}から降順`
          );
        }
      }
      this.talk_order =
        talk_orders[Math.floor(Math.random() * talk_orders.length)];
    },

    // ルーレットのボタンを切り替える。
    active() {
      this.is_active = !this.is_active;
    },

    // ルーレットの内容の配列からランダムで1つデータを表示させることを0.1秒ごとに繰り返す。
    roulette() {
      let roulette = setInterval(() => {
        if (this.is_active) {
          this.talkOrder();
        } else {
          // 0.1秒ごとに1つデータを表示させることを止める。
          clearInterval(roulette);
        }
      }, 100);
    },

    // このルーレットの説明が書かれたモーダルウィンドウが開く。
    clickEvent() {
      this.$emit("openModal", this.roulette_type);
    },
  },
};
</script>

<style scoped>
</style>
