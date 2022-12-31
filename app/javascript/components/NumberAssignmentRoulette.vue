<template>
  <div class="mb-3">
    <div class="mb-2">
      <span class="me-2">番号指定</span>
      <span class="modal_btn" @click="clickEvent">?</span>
    </div>
    <div class="row">
      <!-- ルーレット表示部分 -->
      <div class="col-11 p-2 roulette">
        {{ numbering }}
      </div>
      <!-- /ルーレット表示部分 -->
      <!-- ルーレットボタン -->
      <div
        class="col-1 text-white px-0"
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
  </div>
</template>

<script>
export default {
  created() {
    this.assignNumber();
  },
  data() {
    return {
      numbering: {}, // ルーレットを止めた時に表示する内容。
      is_active: false, // ルーレットのボタンの切り替え。
      roulette_type: "number_assignment", // ルーレットの種類。
    };
  },
  emits: ["openModal"],
  methods: {
    // ルーレットの内容の配列を作成し、その配列からランダムで1つデータを表示させる。
    assignNumber() {
      const numberings = [
        "誕生日が早い順",
        "誕生日が遅い順",
        "ルーレットを回した人から右回り",
        "ルーレットを回した人から左回り",
        "苗字の最初の文字が五十音で早い順",
        "苗字の最初の文字が五十音で遅い順",
        "名前の最初の文字が五十音で早い順",
        "名前の最初の文字が五十音で遅い順",
      ];
      this.numbering =
        numberings[Math.floor(Math.random() * numberings.length)];
    },

    // ルーレットのボタンを切り替える。
    active() {
      this.is_active = !this.is_active;
    },

    // ルーレットの内容の配列からランダムで1つデータを表示させることを0.1秒ごとに繰り返す。
    roulette() {
      let roulette = setInterval(() => {
        if (this.is_active) {
          this.assignNumber();
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
