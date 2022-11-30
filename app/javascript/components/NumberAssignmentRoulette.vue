<template>
  <div class="mb-3">
    <div>
      <span class="fs-5">番号指定</span>
      <span @click="clickEvent">?</span>
    </div>
    <div class="row">
      <div class="col-11 p-2 number_assignment_roulette">
        {{ numbering }}
      </div>
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
      numbering: {},
      is_active: false,
    };
  },
  emits: ["openModal"],
  methods: {
    assignNumber: function () {
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
    active() {
      this.is_active = !this.is_active;
    },
    roulette: function () {
      let roulette = setInterval(() => {
        if (this.is_active) {
          this.assignNumber();
        } else {
          clearInterval(roulette);
        }
      }, 100);
    },
    clickEvent() {
      this.$emit("openModal");
    },
  },
};
</script>

<style scoped>
.number_assignment_roulette {
  border: 1px solid #000;
  font-weight: bold;
  text-align: center;
}
</style>
