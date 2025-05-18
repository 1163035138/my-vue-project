<template>
  <div class="about">
    <h1>{{ user }}</h1>
  </div>
</template>
<script setup>
import axios from "axios";
import { onMounted, ref } from "vue";
const user = ref("");
onMounted(() => {
  axios.get("http://localhost:3000/user").then((res) => {
    user.value = res.data;
  });
});
</script>
