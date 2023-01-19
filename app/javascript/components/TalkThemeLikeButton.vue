<template>
  <dd>
    <!-- いいねをした時に表示されるいいねボタン -->
    <div v-if="isLiked" @click="deleteLike">
      <i class="fas fa-heart create-heart me-2"></i>
      <span class="fs-5 like_count">{{ count }}</span>
    </div>

    <!-- いいねをしていない時に表示されるいいねボタン -->
    <div v-else @click="createLike">
      <i class="far fa-heart destroy-heart me-2"></i>
      <span class="fs-5 like_count">{{ count }}</span>
    </div>
  </dd>
</template>

<script>
import axios from "axios";

export default {
  props: {
    talk_theme_id: "", // このトークテーマのid。
    likes: {}, // このトークテーマに関連したいいねデータ。
    
    // 接続しているipアドレスをipカラムに保存しているいいねデータのtalk_theme_idカラムの値の配列。
    liked_talk_theme_ids: {
      type: Array,
    },
  },
  emits: [
    // いいねされたトークテーマのidの配列にこのトークテーマのidを追加する。
    "addLikedTalkTheme", 

    // いいねされたトークテーマのidの配列からこのトークテーマのidを削除する。
    "removeLikedTalkTheme"
  ],
  data() {
    return {
      likes_count: "", // このトークテーマのいいね数。
    };
  },
  created() {
    // このトークテーマに紐づいたいいねデータ数をlikes_countに代入する。
    this.likes_count = this.likes.length;
  },
  computed: {
    // このトークテーマのいいね数を表示。
    count() {
      return this.likes_count;
    },

    // このトークテーマのいいねの有無を判断。
    isLiked() {
      return this.liked_talk_theme_ids.includes(this.talk_theme_id);
    },
  },
  methods: {
    // このトークテーマにいいねをする。
    createLike() {
      const id = this.talk_theme_id;
      axios
        // いいねデータを保存する。
        .post(`/api/v1/talk_themes/${id}/like`, {
          talk_theme_id: id,
        })
        .then(() => {
          // いいね数を1加える。
          this.likes_count += 1;

          // いいねされたトークテーマのidの配列にこのトークテーマのidを追加する。
          this.$emit("addLikedTalkTheme", id);
        });
    },

    // トークテーマのいいねを取り消す。
    deleteLike() {
      const id = this.talk_theme_id;
      axios
        // いいねデータを削除する。
        .delete(`/api/v1/talk_themes/${id}/like`)
        .then(() => {
          // いいね数を1減らす。
          this.likes_count -= 1;

          // いいねされたトークテーマのidの配列からこのトークテーマのidを削除する。
          this.$emit("removeLikedTalkTheme", id);
        });
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

.like_count {
  vertical-align: top;
}
</style>
