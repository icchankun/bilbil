<template>
  <div>
    <div class="fs-5">トーク順番</div>
    <div class="row">
      <div class="col-9 p-2 talk_order_roulette">
        {{ talk_order }}
      </div>
      <div
        class="col-2 text-white px-0"
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
    this.talkOrder();
  },
  props: {
    number_of_people: "",
  },
  data() {
    return {
      talk_order: {},
      is_active: false,
    };
  },
  watch: {
    number_of_people: function () {
      this.talkOrder();
    },
  },
  methods: {
    talkOrder: function () {
      const talk_orders = [];
      if (this.number_of_people == 2) {
        talk_orders.push("1の人から", "2の人から");
      } else {
        for (let n = 1; n <= this.number_of_people; n++) {
          talk_orders.push(`${n}の人から右回り`, `${n}の人から左回り`,`${n}から昇順`,`${n}から降順`);
        }
      }
      this.talk_order =
        talk_orders[Math.floor(Math.random() * talk_orders.length)];
    },
    active() {
      this.is_active = !this.is_active;
    },
    roulette: function () {
      let roulette = setInterval(() => {
        if (this.is_active) {
          this.talkOrder();
        } else {
          clearInterval(roulette);
        }
      }, 100);
    },
  },
};
</script>

<style scoped>
.talk_order_roulette {
  border: 1px solid #000;
  font-weight: bold;
  text-align: center;
}
</style>
