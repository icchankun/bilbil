<template>
  <div v-if="show_content" id="overlay">
    <div class="modal_window">
      <!-- 番号指定ルーレット説明文 -->
      <div v-if="roulette_type == 'number_assignment'">
        <h3 class="mb-3">番号指定ルーレット</h3>
        <div class="mb-3">
          このルーレットの指示で各参加者に番号を振ります。<br />
          例)「誕生日が早い順」とルーレットに表示された場合は、誕生日が早い順に1,
          2と各参加者に番号を振っていきます。
        </div>
      </div>
      <!-- /番号指定ルーレット説明文 -->
      <!-- トーク順番ルーレット説明文 -->
      <div v-else-if="roulette_type == 'talk_order'">
        <h3 class="mb-2">トーク順番ルーレット</h3>
        <div class="mb-3">
          このルーレットの指示と番号指定ルーレットによって決めた番号をもとにトークする順番を決めてください。
        </div>
      </div>
      <!-- /トーク順番ルーレット説明文 -->
      <!-- 司会者・話し手指定ルーレット説明文 -->
      <div v-else>
        <h3 class="mb-2">司会者・話し手指定ルーレット</h3>
        <div class="mb-3">
          このルーレットの指示と番号指定ルーレットによって決めた番号をもとに司会者や話し手を決めることもできます。
        </div>
      </div>
      <span class="btn btn-primary" @click="clickEvent">閉じる</span>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    show_content: "", // モーダルウィンドウの表示の有無。
    roulette_type: "", // ルーレットの種類。
  },
  emits: ["closeModal"],
  methods: {
    // モーダルウィンドウを閉じる。
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
.modal_window {
  z-index: 2;
  padding: 1em;
  background: #fff;
}
</style>
