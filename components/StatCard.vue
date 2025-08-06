<template>
  <div class="p-4 rounded-lg border border-gray-100">
    <div class="text-sm text-gray-600 mb-1">{{ title }}</div>
    <div class="text-2xl font-semibold" :class="color">{{ value }}</div>
  </div>
</template>

<script setup>
defineProps({
  title: {
    type: String,
    required: true
  },
  value: {
    type: [String, Number],
    required: true
  },
  color: {
    type: String,
    default: 'text-gray-900'
  }
})
</script>