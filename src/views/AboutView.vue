<template>
  <div class="about">
    <h1>This is an about page</h1>
  </div>
</template>
<script setup>
import axios from 'axios'
import { onMounted } from 'vue'
onMounted(() => {
  axios.get('http://localhost:3000/user').then((res) => {
    console.log(res)
  })
})
</script>
