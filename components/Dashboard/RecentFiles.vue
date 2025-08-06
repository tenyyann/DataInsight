<script setup>
import { FileText, Clock } from 'lucide-vue-next'

const files = [
  {
    name: 'sales_data_2024.xlsx',
    time: '2 hours ago',
    errors: null,
    status: 'completed',
  },
  {
    name: 'customer_analytics.csv',
    time: '4 hours ago',
    errors: 2,
    status: 'processing',
  },
  {
    name: 'inventory_report.xlsx',
    time: '1 day ago',
    errors: 1,
    status: 'completed',
  },
  {
    name: 'financial_data_q4.csv',
    time: '2 days ago',
    errors: 5,
    status: 'failed',
  },
]

const statusColor = {
  completed: 'text-green-600 bg-green-100',
  processing: 'text-yellow-600 bg-yellow-100',
  failed: 'text-red-600 bg-red-100',
}
</script>

<template>
  <div class="p-6 bg-white rounded-2xl shadow-md space-y-4">
    <div>
      <h2 class="text-lg font-semibold text-gray-900">Recent Files</h2>
      <p class="text-sm text-gray-500">Your latest data analysis files</p>
    </div>

    <ul class="divide-y divide-gray-200">
      <li v-for="(file, index) in files" :key="index" class="py-4 flex items-start justify-between">
        <div class="flex items-center space-x-3">
          <FileText class="w-5 h-5 text-gray-400" />
          <div>
            <p class="font-medium text-gray-800">{{ file.name }}</p>
            <div class="text-sm text-gray-500 flex items-center space-x-2">
              <Clock class="w-4 h-4" />
              <span>{{ file.time }}</span>
              <span v-if="file.errors !== null" class="text-xs text-gray-400">• {{ file.errors }} error(s)</span>
            </div>
          </div>
        </div>
        <span
          :class="[
            'px-3 py-1 text-xs font-medium rounded-full',
            statusColor[file.status] || 'text-gray-600 bg-gray-100'
          ]"
        >
          {{ file.status }}
        </span>
      </li>
    </ul>
  </div>
</template>
