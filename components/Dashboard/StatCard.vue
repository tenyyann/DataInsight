<script setup>
defineProps({
  icon: Object,
  title: String,
  value: String,
  percentage: String,
  isPositive: Boolean
})
</script>

<template>
  <div class="p-4 rounded-2xl bg-white shadow-md flex flex-col gap-3">
    <div class="flex items-center justify-between">
      <component :is="icon" class="w-6 h-6 text-blue-600" />
    </div>
    <div>
      <h3 class="text-sm text-gray-500">{{ title }}</h3>
      <p class="text-xl font-bold">{{ value }}</p>
    </div>
    <div :class="['text-sm font-medium', isPositive ? 'text-green-600' : 'text-red-600']">
      {{ percentage }} {{ isPositive ? '↑' : '↓' }} from last month
    </div>
  </div>
</template>
