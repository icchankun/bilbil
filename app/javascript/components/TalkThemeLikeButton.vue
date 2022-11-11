<template>
  <dd>
    <div class="" v-if="isLiked" @click="deleteLike()">
      <i class="fas fa-heart create-heart me-2"></i>
      <span>{{ count }}</span>
    </div>
    <div class="heart-size" v-else @click="createLike()">
      <i class="far fa-heart destroy-heart me-2"></i>
      <span>{{ count }}</span>
    </div>
  </dd>
</template>

<script>
import axios from "axios";

export default {
  props: {
    talk_theme_id: "",
    likes: {},
  },
  emits: ["fetchCategories", "fetchLikesByIpAddress"],
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
          this.$emit("fetchCategories");
          this.$emit("fetchLikesByIpAddress");
        });
    },
    deleteLike: function () {
      axios
        .delete(`/api/v1/talk_themes/${this.talk_theme_id}/like`)
        .then(() => {
          this.fetchLikeByTalkThemeId();
          this.findLikeByIpAddress();
          this.$emit("fetchCategories");
          this.$emit("fetchLikesByIpAddress");
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

<style scoped>
.fa-heart {
  font-size: 1.7rem;
}
.create-heart {
  color: #de3f4e;
}

.destroy-heart {
  color: #707070;
}
</style>
