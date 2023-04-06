<template>
  <div v-if="this.participants.length != 0">
    <div class="mb-1">トーク順番</div>
    <ul class="p-0 m-0">
      <li v-for="(participant, index) in participants" class="participant_names">
        <div>{{ index + 1 }}.</div>
        <div>{{ participant.name }}</div>
        <div class="p-2 delete_btn" @click="deleteName(index)">
          <i class="fas fa-times"></i>
        </div>
      </li>
    </ul>
    <div  v-if="this.participants.length >= 2" class="text-center">
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
          <span>シャッフル</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      is_active: false,
    };
  },
  props: {
    modelValue: {
      type: Array,
    },
  },
  emits: ["update:modelValue"],
  computed: {
    participants: {
      get() {
        return this.modelValue;
      },
      set(newVal) {
        this.$emit("update:modelValue", newVal);
      },
    },
  },
  methods: {
    deleteName(index) {
      // 名前を削除する
      this.participants.splice(index, 1);

      // ローカルストレージにデータを保存する
      localStorage.setItem("participants", JSON.stringify(this.participants));
    },

    arrayShuffle() {
      for (let i = this.participants.length - 1; 0 < i; i--) {
        // 0〜(i+1)の範囲で値を取得
        let r = Math.floor(Math.random() * (i + 1));

        // 要素の並び替えを実行
        let tmp = this.participants[i];
        this.participants[i] = this.participants[r];
        this.participants[r] = tmp;
      }
    },

    // ルーレットのボタンを切り替える。
    active() {
      this.is_active = !this.is_active;
    },

    // トーク参加者の並び順の変更を0.08秒ごとに繰り返す。
    roulette() {
      let roulette = setInterval(() => {
        if (this.is_active) {
          this.arrayShuffle();
        } else {
          // 0.08秒ごとのトーク参加者の並び順の変更を止める。
          clearInterval(roulette);
        }
      }, 80);
    },
  },
};
</script>

<style lang="scss" scoped>
.participant_names {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 0.5em 0 1em;
  margin-bottom: 1em;
  background-color: #c7c2c2;
  border-radius: 0.375rem;
  .delete_btn {
    cursor: pointer;
  }
  .fa-times {
    font-size: 2rem;
  }
}
</style>
