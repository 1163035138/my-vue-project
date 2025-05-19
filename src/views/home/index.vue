<template>
  <div>
    <Xiangce />
  </div>
</template>
<script setup>
import Xiangce from "@/components/3dpic/index.vue";
import axios from "axios";
import { onMounted } from "vue";
onMounted(() => {
  axios({
    url: "/api/user",
    method: "get",
  });
});
</script>
<style scoped></style>
