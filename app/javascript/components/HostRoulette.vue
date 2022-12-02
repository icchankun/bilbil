<template>
  <div class="mb-2">
    <span class="fs-5 me-2">司会者・話し手指定</span>
    <span class="modal_btn" @click="clickEvent">?</span>
  </div>
  <div class="row">
    <div class="col-7 p-2 host_roulette">
      {{ host }}
    </div>
    <div
      class="col-3 text-white px-0"
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
</template>

<script>
export default {
  created() {
    this.assignHost();
  },
  props: {
    number_of_people: "",
  },
  emits: ["openModal"],
  data() {
    return {
      host: {},
      is_active: false,
      roulette_type: "host",
    };
  },
  watch: {
    number_of_people: function () {
      this.assignHost();
    },
  },
  methods: {
    assignHost: function () {
      const hosts = [];
      for (let n = 1; n <= this.number_of_people; n++) {
        hosts.push(`${n}の人`);
      }
      this.host = hosts[Math.floor(Math.random() * hosts.length)];
    },
    active() {
      this.is_active = !this.is_active;
    },
    roulette: function () {
      let roulette = setInterval(() => {
        if (this.is_active) {
          this.assignHost();
        } else {
          clearInterval(roulette);
        }
      }, 100);
    },
    clickEvent() {
      this.$emit("openModal", this.roulette_type);
    },
  },
};
</script>

<style scoped>
.host_roulette {
  border: 1px solid #000;
  font-weight: bold;
  text-align: center;
}
</style>
