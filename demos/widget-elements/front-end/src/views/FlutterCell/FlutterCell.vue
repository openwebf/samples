<template>
    <div>
        <h2>Cell Demo</h2>
        <div class="container">
            <flutter-cell title="Cell title2" value="Content" />
            <flutter-button id="back" @click="this.$router.back()"> Back </flutter-button>
        </div>
    </div>
</template>
    
<style scoped>
.container {
    width: 200px;
    margin: 0 auto;
    border: 2px solid #000;
}
</style>

<script>
</script>
    