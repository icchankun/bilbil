<template>
  <dd>
    <div v-if="isLiked" @click="deleteLike()">いいねを取り消す {{ count }}</div>
    <div v-else @click="createLike()">いいねする {{ count }}</div>
  </dd>
</template>

<script>
import axios from "axios";

export default {
  props: {
    talk_theme_id: "",
    likes: {},
  },
  data() {
    return {
      isLiked: "",
      date_likes: {},
      likes_count: "",
    };
  },
  created() {
    this.likes_count = this.likes.length;
    this.findLikeByIpAddress();
  },
  computed: {
    count() {
      return this.likes_count;
    },
    isLike() {
      return Boolean(this.isLiked);
    },
  },
  methods: {
    createLike: function () {
      axios
        .post(`/api/v1/talk_themes/${this.talk_theme_id}/like`, {
          talk_theme_id: this.talk_theme_id,
        })
        .then(() => {
          this.fetchLikeByTalkThemeId();
          this.findLikeByIpAddress();
        });
    },
    deleteLike: function () {
      axios
        .delete(`/api/v1/talk_themes/${this.talk_theme_id}/like`)
        .then(() => {
          this.fetchLikeByTalkThemeId();
          this.findLikeByIpAddress();
        });
    },
    fetchLikeByTalkThemeId: function () {
      axios
        .get(`/api/v1/talk_themes/${this.talk_theme_id}/like`)
        .then((response) => {
          this.date_likes = response.data;
          this.likes_count = this.date_likes.length;
        });
    },
    findLikeByIpAddress: function () {
      axios
        .get(`/api/v1/talk_themes/${this.talk_theme_id}/like/judge`)
        .then((response) => (this.isLiked = response.data));
    },
  },
};
</script>

<style scoped></style>
