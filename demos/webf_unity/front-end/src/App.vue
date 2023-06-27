<template>
    <div class="unity-container">
        <flutter-unity ref="unity" id="unity"></flutter-unity>
        <div class="speed-control">
            <div class="num" @click="decreaseSpeed">-</div>
            <div class="speed">{{ speed.toFixed(1) }}</div>
            <div class="num" @click="increaseSpeed">+</div>
        </div>
    </div>
</template>

<script>

export default {
    name: 'App',
    data: () => {
        return {
            speed: 0
        };
    },
    methods: {
        decreaseSpeed() {
            if (this.speed <= 0.09) return;
            this.speed -= 0.1;

            this.$refs.unity.setRotationSpeed(this.speed);

        },
        increaseSpeed() {
            if (this.speed >= 0.99) return;
            this.speed += 0.1;
            this.$refs.unity.setRotationSpeed(this.speed);
        }
    },
    components: {},
}
</script>

<style>
.unity-container {
    position: relative;
}

.unity-container, #unity {
    width: 100vw;
    height: 100vh;
}

.speed-control {
    position: absolute;
    width: 60vw;
    left: 0;
    right: 0;
    bottom: 50px;
    margin: auto;
    background: white;
    display: flex;
    flex-direction: row;
    padding: 10px 5px;
    justify-content: space-around;
}

.speed-control .num {
    font-size: 45px;
    line-height: 45px;
}

.speed {
    font-size: 30px;
    line-height: 45px;
    width: 80px;
    text-align: center;
}

</style>

