<template>
  <div>
    <h1>首页</h1>
  </div>
</template>
<script setup>
import axios from "axios";
import { onMounted } from "vue";
onMounted(() => {
  axios({
    url: "/api/user",
    method: "post",
    data: {
      name: "张三",
      age: 18,
    },
  });
});
</script>
<style scoped></style>
