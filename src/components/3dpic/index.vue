<template>
  <div class="container">
    <div class="wrap">
      <img src="@/assets/微信图片_20240110214235.jpg" alt="图片" />
      <img src="@/assets/微信图片_20240110214234.jpg" alt="图片" />
      <img src="@/assets/微信图片_20240110214232.jpg" alt="图片" />
      <img src="@/assets/微信图片_20240110214231.jpg" alt="图片" />
      <img src="@/assets/微信图片_20240110214230.jpg" alt="图片" />
      <img src="@/assets/微信图片_20240110214229.jpg" alt="图片" />
      <img src="@/assets/微信图片_20240110214228.jpg" alt="图片" />
      <img src="@/assets/微信图片_20240110214226.jpg" alt="图片" />
      <img src="@/assets/微信图片_20240110214225.jpg" alt="图片" />
      <img src="@/assets/微信图片_20240110214224.jpg" alt="图片" />
      <img src="@/assets/微信图片_20240110214223.jpg" alt="图片" />
      <img src="@/assets/微信图片_20240110214222.jpg" alt="图片" />
    </div>
  </div>
</template>
<script setup>
import { onMounted } from "vue";
onMounted(() => {
  // 获取dom
  const container = document.querySelector(".container");
  const wrap = document.querySelector(".wrap");
  const imgList = document.querySelectorAll(".wrap img");
  const length = imgList.length;
  // 计算图片间隔角度
  const angle = 360 / length;

  // 开场动画 延时1000 / 60 = 16.666667 ≈ 17，否则transition不会生效
  setTimeout(() => {
    for (let i = 0; i < length; i++) {
      // 每张图片过渡效果间隔0.1s
      imgList[i].style.transition =
        "transform 1s ease " + (length - 1 - i) * 0.1 + "s";
      // 沿着z轴偏移320像素（此距离自己设置，觉得合适即可），否则图片会挤在一起
      imgList[i].style.transform =
        "rotateY(" + angle * i + "deg) translateZ(320px)";
    }
  }, 17);
  // wrap沿x轴旋转-10度
  const rotate = { x: -10, y: 0 };
  wrap.style.transform = "rotateX(" + rotate.x + "deg)";

  let isPointerDown = false;
  let last = null;
  let diff = null;
  let rafId = null;
  // 监听pointerdown事件
  container.addEventListener("pointerdown", function (e) {
    this.setPointerCapture(e.pointerId);
    isPointerDown = true;
    // 停止动画
    cancelAnimationFrame(rafId);
    last = { x: e.clientX, y: e.clientY };
    diff = { x: 0, y: 0 };
  });
  // 监听pointermove事件
  container.addEventListener("pointermove", function (e) {
    if (isPointerDown) {
      const current = { x: e.clientX, y: e.clientY };
      // 计算相对于上一次移动差值
      diff = { x: current.x - last.x, y: current.y - last.y };
      // 旋转角度，乘以0.1是为了降低旋转敏感度，防止旋转过快。可自行设置合适的值
      rotate.x -= diff.y * 0.1;
      rotate.y += diff.x * 0.1;
      last = { x: current.x, y: current.y };
      wrap.style.transform =
        "rotateX(" + rotate.x + "deg) rotateY(" + rotate.y + "deg)";
    }
  });
  function raf() {
    // ES6解构赋值
    let { x, y } = diff;
    function step() {
      // 摩擦力
      x *= 0.95;
      y *= 0.95;
      rotate.x -= y * 0.1;
      rotate.y += x * 0.05;
      wrap.style.transform =
        "rotateX(" + rotate.x + "deg) rotateY(" + rotate.y + "deg)";
      // 小于1停止动画
      if (Math.abs(x) > 1 || Math.abs(y) > 1) {
        rafId = requestAnimationFrame(step);
      }
    }
    rafId = requestAnimationFrame(step);
  }

  // 监听pointerup事件
  container.addEventListener("pointerup", function () {
    isPointerDown = false;
    // 惯性滚动
    raf();
  });
  // 监听pointercancel事件
  container.addEventListener("pointercancel", function () {
    isPointerDown = false;
  });
});
</script>
<style scoped lang="scss">
* {
  margin: 0;
  padding: 0;
}
.container {
  display: flex;
  min-height: 100vh;
  perspective: 800px;
  background: #000;
  touch-action: none;
}
.wrap {
  position: relative;
  width: 120px;
  height: 180px;
  margin: auto;
  transform-style: preserve-3d;
  pointer-events: none;
}
.wrap img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 2px;
}
</style>
