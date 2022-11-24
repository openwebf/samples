<template>
  <h2> Widget Elements Demo</h2>

  <ul>
    <li @click="this.$router.push('/action-sheet')">Flutter Action Sheet With Data</li>
    <li @click="this.$router.push('/action-sheet-child')">Flutter Action Sheet with Customize Contents</li>
  </ul>
</template>

<script>
export default {
  name: 'Hello-world',
  components: {
  }
}
</script>

<style>
h2 {
  text-align: center;
}
</style>
