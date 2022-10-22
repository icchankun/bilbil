<template>
  <div v-if="errors.length != 0">
    <ul v-for="error in errors" :key="error">
      <li>
        <font color="red">{{ error }}</font>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  props: {
    errors: ""
  }
}
</script>

<style scoped></style>
