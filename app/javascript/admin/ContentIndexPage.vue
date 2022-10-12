<template>
  <table>
    <tbody>
      <tr>
        <th>content</th>
      </tr>
      <tr v-for="talk_theme in talk_themes" :key="talk_theme.id">
        <td>{{ talk_theme.content }}</td>
      </tr>
    </tbody>
  </table>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      talk_themes: []
    }
  },
  mounted() {
    axios
      .get('/api/v1/talk_themes.json')
      .then(response => (this.talk_themes = response.data))
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: left;
}
</style>