<template>
  <footer class="footer bg-dark">
    <div class="container p-2">
      <div>
        <slot name="notice"></slot>
      </div>
      <div>
        <slot name="twitter_promotion"></slot>
      </div>
      <div>
        <slot name="twitter_account"></slot>
      </div>
      <div class="text-center">
        <span class="text-white">@bilbil</span>
      </div>
    </div>
  </footer>
</template>

<script>
</script>

<style scoped>
  .footer {
    width: 100%;
    position: absolute;
    bottom: 0;
  }
</style>