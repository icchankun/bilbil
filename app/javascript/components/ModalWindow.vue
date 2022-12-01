<template>
  <div v-if="show_content" id="overlay">
    <div id="content">
      <p v-if="roulette_type == 'number_assignment'">番号指定ルーレット</p>
      <p v-else-if="roulette_type == 'talk_order'">トーク順番ルーレット</p>
      <p v-else>司会者・話し手ルーレット</p>
      <p><button @click="clickEvent">close</button></p>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    show_content: "",
    roulette_type: "",
  },
  emits: ["closeModal"],
  methods: {
    clickEvent() {
      this.$emit("closeModal");
    },
  },
};
</script>

<style scoped>
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
</style>
