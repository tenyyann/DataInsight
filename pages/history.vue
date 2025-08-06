<template>
  <div class="bg-white p-6 rounded-lg border border-gray-200">
    <!-- Stats Cards -->
    <div class="grid grid-cols-4 gap-4 mb-8">
      <div class="p-4 rounded-lg border border-gray-100">
        <div class="text-sm text-gray-600 mb-1">Total Files</div>
        <div class="text-2xl font-semibold">{{ stats.total }}</div>
      </div>
      <StatCard
        title="Completed"
        :value="stats.completed"
        icon="CheckCircle"
        class="text-green-600"
      />
      <StatCard
        title="Processing"
        :value="stats.processing"
        icon="Clock"
        class="text-blue-600"
      />
      <StatCard
        title="Failed"
        :value="stats.failed"
        icon="XCircle"
        class="text-red-600"
      />
    </div>

    <!-- Analysis History Section -->
    <div>
      <h3 class="text-lg font-semibold mb-2">Analysis History</h3>
      <p class="text-gray-500 text-sm mb-4">Complete history of your data analysis files</p>

      <!-- Search and Filter -->
      <div class="flex justify-between items-center mb-4">
        <div class="relative">
          <Search class="absolute left-3 top-2.5 w-4 h-4 text-gray-400" />
          <input 
            type="text" 
            placeholder="Search files..." 
            class="pl-9 pr-4 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-gray-200"
          >
        </div>
        <select class="px-4 py-2 border border-gray-200 rounded-lg text-sm">
          <option>All Status</option>
          <option>Completed</option>
          <option>Processing</option>
          <option>Failed</option>
        </select>
      </div>

      <!-- Table -->
      <div class="overflow-x-auto">
        <table class="min-w-full">
          <thead>
            <tr class="border-b border-gray-100">
              <th class="py-3 text-left text-sm font-medium text-gray-600">File Name</th>
              <th class="py-3 text-left text-sm font-medium text-gray-600">Upload Date</th>
              <th class="py-3 text-left text-sm font-medium text-gray-600">Status</th>
              <th class="py-3 text-left text-sm font-medium text-gray-600">Records</th>
              <th class="py-3 text-left text-sm font-medium text-gray-600">Quality Score</th>
              <th class="py-3 text-left text-sm font-medium text-gray-600">Alerts</th>
              <th class="py-3 text-left text-sm font-medium text-gray-600">Size</th>
              <th class="py-3 text-left text-sm font-medium text-gray-600">Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="file in files" :key="file.name" class="border-b border-gray-50">
              <td class="py-4 text-sm text-gray-900">{{ file.name }}</td>
              <td class="py-4 text-sm text-gray-600">{{ file.uploadDate }}</td>
              <td class="py-4">
                <span :class="getStatusClass(file.status)">
                  {{ file.status }}
                </span>
              </td>
              <td class="py-4 text-sm text-gray-900">{{ file.records?.toLocaleString() || '-' }}</td>
              <td class="py-4 text-sm text-gray-900">{{ file.qualityScore || '-' }}</td>
              <td class="py-4 text-sm text-gray-900">{{ file.alerts }}</td>
              <td class="py-4 text-sm text-gray-600">{{ file.size }}</td>
              <td class="py-4">
                <button class="text-gray-400 hover:text-gray-600">
                  <MoreVertical class="w-4 h-4" />
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script setup>
import { Search, MoreVertical, CheckCircle, Clock, XCircle } from 'lucide-vue-next'

const stats = {
  total: 6,
  completed: 4,
  processing: 1,
  failed: 1
}

const files = [
  {
    name: 'sales_data_2024.xlsx',
    uploadDate: '2024-01-15',
    status: 'completed',
    records: 1250,
    qualityScore: '87/100',
    alerts: 3,
    size: '2.4 MB'
  },
  {
    name: 'customer_analytics.csv',
    uploadDate: '2024-01-14',
    status: 'processing',
    records: 850,
    qualityScore: '-',
    alerts: '-',
    size: '1.8 MB'
  },
  {
    name: 'inventory_report.xlsx',
    uploadDate: '2024-01-13',
    status: 'completed',
    records: 2100,
    qualityScore: '92/100',
    alerts: 1,
    size: '3.1 MB'
  },
  {
    name: 'financial_data_q4.csv',
    uploadDate: '2024-01-12',
    status: 'failed',
    records: null,
    qualityScore: '-',
    alerts: 5,
    size: '1.2 MB'
  },
  {
    name: 'employee_survey.xlsx',
    uploadDate: '2024-01-11',
    status: 'completed',
    records: 340,
    qualityScore: '95/100',
    alerts: 0,
    size: '890 KB'
  },
  {
    name: 'product_catalog.csv',
    uploadDate: '2024-01-10',
    status: 'completed',
    records: 580,
    qualityScore: '88/100',
    alerts: 2,
    size: '1.5 MB'
  }
]

function getStatusClass(status) {
  const baseClasses = 'px-2 py-1 text-xs font-medium rounded-full'
  switch (status) {
    case 'completed':
      return `${baseClasses} bg-green-50 text-green-700`
    case 'processing':
      return `${baseClasses} bg-blue-50 text-blue-700`
    case 'failed':
      return `${baseClasses} bg-red-50 text-red-700`
    default:
      return `${baseClasses} bg-gray-50 text-gray-700`
  }
}
</script>