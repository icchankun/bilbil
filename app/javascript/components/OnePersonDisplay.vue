<template>
  <div v-if="this.participants.length >= 2" class="mb-3">
    <div class="mb-1">トーク司会者・話し手</div>
    <div class="participant_name mb-3">
      <div>{{ participant.name }}</div>
    </div>
    <div class="text-center">
      <div
        class="d-inline-block text-white"
        @click="
          roulette();
          active();
        "
      >
        <div class="stop_btn p-3" v-if="this.is_active">
          <i class="fas fa-stop-circle me-2"></i>
          <span>ストップ</span>
        </div>
        <div class="start_btn p-3" v-else>
          <i class="fas fa-sync-alt me-2"></i>
          <span>スタート</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  created() {
    this.randomParticipant();
  },
  props: {
    participants: {
      type: Array,
    },
  },
  data() {
    return {
      participant: "",
      is_active: false,
    };
  },
  watch: {
    computedParticipants: {
      handler(new_participants, old_participants) {
        if (new_participants.length != old_participants.length) {
          this.randomParticipant();
        }
      },
      deep: true,
    },
  },
  computed: {
    computedParticipants() {
      return JSON.parse(JSON.stringify(this.participants));
    },
  },
  methods: {
    randomParticipant() {
      this.participant =
        this.participants[
          Math.floor(Math.random() * this.participants.length)
        ] || "";
    },

    // ルーレットのボタンを切り替える。
    active() {
      this.is_active = !this.is_active;
    },

    // トーク参加者からランダムで1人を表示させることを0.08秒ごとに繰り返す。
    roulette() {
      let roulette = setInterval(() => {
        if (this.is_active) {
          this.randomParticipant();
        } else {
          // 0.08秒ごとにトーク参加者からランダムに1人を表示させることを止める。
          clearInterval(roulette);
        }
      }, 80);
    },
  },
};
</script>

<style scoped>
.participant_name {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 1em;
  background-color: #c7c2c2;
  border-radius: 0.375rem;
}
</style>
