<template>
  <div class="bg-white p-6 rounded-lg border border-gray-200">
    <h2 class="text-2xl font-semibold mb-2">Data Alerts</h2>
    <p class="text-gray-500 text-sm mb-8">Issues and recommendations found during analysis</p>

    <div class="space-y-4">
      <!-- Alert item 1 -->
      <div class="p-4 rounded-lg border border-gray-100">
        <div class="flex items-start gap-3">
          <AlertTriangle class="w-5 h-5 text-yellow-500 mt-0.5" />
          <div>
            <h3 class="text-sm font-medium text-gray-900 mb-1">15 duplicate records found</h3>
            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-50 text-yellow-800">
              medium priority
            </span>
          </div>
        </div>
      </div>

      <!-- Alert item 2 -->
      <div class="p-4 rounded-lg border border-gray-100">
        <div class="flex items-start gap-3">
          <AlertTriangle class="w-5 h-5 text-blue-500 mt-0.5" />
          <div>
            <h3 class="text-sm font-medium text-gray-900 mb-1">Date format inconsistency in 3% of records</h3>
            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-50 text-blue-800">
              low priority
            </span>
          </div>
        </div>
      </div>

      <!-- Alert item 3 -->
      <div class="p-4 rounded-lg border border-gray-100">
        <div class="flex items-start gap-3">
          <AlertTriangle class="w-5 h-5 text-red-500 mt-0.5" />
          <div>
            <h3 class="text-sm font-medium text-gray-900 mb-1">Missing values in Email column (5 records)</h3>
            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-50 text-red-800">
              high priority
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { AlertTriangle } from 'lucide-vue-next'

const alerts = [
  {
    message: '15 duplicate records found',
    priority: 'medium',
    icon: 'AlertTriangle'
  },
  {
    message: 'Date format inconsistency in 3% of records',
    priority: 'low',
    icon: 'AlertTriangle'
  },
  {
    message: 'Missing values in Email column (5 records)',
    priority: 'high',
    icon: 'AlertTriangle'
  }
]

function getPriorityClass(priority) {
  switch (priority) {
    case 'high':
      return {
        badge: 'bg-red-50 text-red-800',
        icon: 'text-red-500'
      }
    case 'medium':
      return {
        badge: 'bg-yellow-50 text-yellow-800',
        icon: 'text-yellow-500'
      }
    case 'low':
      return {
        badge: 'bg-blue-50 text-blue-800',
        icon: 'text-blue-500'
      }
    default:
      return {
        badge: 'bg-gray-50 text-gray-800',
        icon: 'text-gray-500'
      }
  }
}
</script>