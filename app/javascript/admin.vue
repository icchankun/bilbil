<template>
  <p>
    {{ message }}
  </p>
</template>

<script>
export default {
  data() {
    return {
      message: "Hello Vue3!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: left;
}
</style>