<template>
  <Header>B I L B I L</Header>
  <main class="container my-5">
    <div class="row">
      <div class="col-12 col-sm-6 mx-auto">
        <div class="px-1 mb-5">
          <talk-theme-roulette></talk-theme-roulette>
        </div>
        <div class="px-1">
          <head-line>TALK SUPPORT</head-line>
          <number-assignment-roulette></number-assignment-roulette>
        </div>
      </div>
    </div>
  </main>
  <end-user-footer></end-user-footer>
</template>

<script>
import Header from "../components/Header.vue";
import HeadLine from "../components/Headline.vue";
import TalkThemeRoulette from "../components/TalkThemeRoulette.vue";
import NumberAssignmentRoulette from "../components/NumberAssignmentRoulette.vue";
import EndUserFooter from "../components/EndUserFooter.vue";

export default {
  components: {
    Header,
    HeadLine,
    TalkThemeRoulette,
    NumberAssignmentRoulette,
    EndUserFooter,
  },
};
</script>

<style scoped></style>
