<script setup>
import { Upload, BarChart3, FileText, LineChart } from 'lucide-vue-next'
</script>

<template>
  <div class="p-6 bg-white rounded-2xl shadow-md space-y-4">
    <div>
      <h2 class="text-lg font-semibold text-gray-900">Quick Actions</h2>
      <p class="text-sm text-gray-500">Common tasks and shortcuts</p>
    </div>

    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
      <button class="quick-action">
        <Upload class="w-5 h-5 mr-2" />
        Upload New Dataset
      </button>
      <button class="quick-action">
        <BarChart3 class="w-5 h-5 mr-2" />
        View Analytics Dashboard
      </button>
      <button class="quick-action">
        <FileText class="w-5 h-5 mr-2" />
        Generate Report
      </button>
      <button class="quick-action">
        <LineChart class="w-5 h-5 mr-2" />
        Trend Analysis
      </button>
    </div>
  </div>
</template>

<style scoped>
.quick-action {
  @apply flex items-center px-4 py-2 rounded-lg bg-gray-100 hover:bg-gray-200 text-sm font-medium text-gray-700 transition-colors;
}
</style>
