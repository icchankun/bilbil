<template>
  <Header>G U I D E</Header>
  <main class="container my-5">
    <div class="row mx-2">
      <div class="col-lg-7 mx-auto">
        <!-- トークテーマルーレットの使用方法説明 -->
        <head-line>TALK THEME</head-line>
        <ol class="fw-bold mb-5">
          <li class="mb-3">
            お好きなトークテーマのカテゴリーを選択します。
            <div class="fw-normal mb-2">
              ※選択したカテゴリーボタンの色はグレーに変化します。
            </div>
            また、｢いいねしたトークテーマのみをルーレットに表示する｣のボタンを入りにすると、トークテーマ一覧でいいねしたトークテーマのみがルーレットに表示されるようになります。
            <div class="fw-normal">
              ※ボタンを入りにすると色は青に変化します。
            </div>
          </li>
          <li>
            トークテーマルーレット下のスタート・ストップボタンによって、トークテーマを決定します。
          </li>
        </ol>
        <!-- /トークテーマルーレットの使用方法説明 -->
        <!-- トークサポートの使用方法説明 -->
        <head-line>TALK SUPPORT</head-line>
        <ol class="fw-bold mb-5">
          <li class="mb-3">
            トーク参加者の名前をフォームから2人以上追加することで、トーク司会者・話し手/順番を決定する機能を使えるようになります。
          </li>
          <li>
            トーク司会者・話し手はスタート・ストップボタンによって、トーク順番はシャッフル・ストップボタンによって、それぞれ決定することができます。
          </li>
        </ol>
        <!-- /トークサポートの使用方法説明 -->
      </div>
      <!-- ページ遷移リンク -->
      <div>
        <div class="text-center mb-3">
          <router-link class="py-1" to="/content"
            >トークテーマの確認はこちらから。</router-link
          >
        </div>
        <roulette-page-back-button></roulette-page-back-button>
      </div>
      <!-- /ページ遷移リンク -->
    </div>
  </main>
  <end-user-footer>
    トークテーマルーレットだけでも利用できますが、トークサポートも合わせて利用していただくことをおすすめします。
  </end-user-footer>
</template>

<script>
import Header from "../components/Header.vue";
import HeadLine from "../components/Headline.vue";
import RoulettePageBackButton from "../components/RoulettePageBackButton.vue";
import EndUserFooter from "../components/EndUserFooter.vue";

export default {
  components: {
    Header,
    HeadLine,
    RoulettePageBackButton,
    EndUserFooter,
  },
};
</script>

<style scoped></style>
