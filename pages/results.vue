<template>
  <div class="p-8">
    <!-- Header -->
    <div class="flex items-center justify-between mb-1">
      <div>
        <h1 class="text-2xl font-bold mb-1">Analysis Results</h1>
        <p class="text-gray-500 text-sm">Detailed insights from your data analysis</p>
      </div>
      <div class="flex gap-4">
        <button class="flex items-center gap-2 px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50">
          <Clock class="w-4 h-4" />
          View Charts
        </button>
        <button class="flex items-center gap-2 px-4 py-2 text-sm font-medium text-white bg-gray-900 rounded-lg hover:bg-gray-800">
          <Download class="w-4 h-4" />
          Export Report
        </button>
      </div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mt-8">
      <div class="bg-white p-6 rounded-lg border border-gray-200">
        <div class="flex justify-between items-start mb-4">
          <h3 class="text-sm font-medium text-gray-500">Total Records</h3>
          <TrendingUp class="w-4 h-4 text-green-500" />
        </div>
        <p class="text-2xl font-bold mb-2">1,250</p>
        <p class="text-sm text-green-600">+12% from last analysis</p>
      </div>

      <div class="bg-white p-6 rounded-lg border border-gray-200">
        <div class="flex justify-between items-start mb-4">
          <h3 class="text-sm font-medium text-gray-500">Average Revenue</h3>
          <TrendingUp class="w-4 h-4 text-green-500" />
        </div>
        <p class="text-2xl font-bold mb-2">$4,250</p>
        <p class="text-sm text-green-600">+8% from last analysis</p>
      </div>

      <div class="bg-white p-6 rounded-lg border border-gray-200">
        <div class="flex justify-between items-start mb-4">
          <h3 class="text-sm font-medium text-gray-500">Completion Rate</h3>
          <TrendingDown class="w-4 h-4 text-red-500" />
        </div>
        <p class="text-2xl font-bold mb-2">94.5%</p>
        <p class="text-sm text-red-600">-2% from last analysis</p>
      </div>

      <div class="bg-white p-6 rounded-lg border border-gray-200">
        <div class="flex justify-between items-start mb-4">
          <h3 class="text-sm font-medium text-gray-500">Data Quality Score</h3>
          <TrendingUp class="w-4 h-4 text-green-500" />
        </div>
        <p class="text-2xl font-bold mb-2">87/100</p>
        <p class="text-sm text-green-600">+5% from last analysis</p>
      </div>
    </div>

    <!-- Tabs -->
    <div class="mt-8 border-b border-gray-200">
      <nav class="flex gap-8">
        <button 
          v-for="tab in tabs" 
          :key="tab.id"
          @click="activeTab = tab.id"
          :class="[
            'px-1 py-4 text-sm font-medium',
            activeTab === tab.id 
              ? 'text-gray-900 border-b-2 border-gray-900' 
              : 'text-gray-500 hover:text-gray-700'
          ]"
        >
          {{ tab.name }}
        </button>
      </nav>
    </div>

    <!-- Dynamic Content -->
    <div class="mt-8">
      <ResultsOverview v-if="activeTab === 'overview'" />
      <ResultsDataQuality v-if="activeTab === 'quality'" />
      <ResultsDataPreview v-if="activeTab === 'preview'" />
      <ResultsAlerts v-if="activeTab === 'alerts'" />
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { Clock, Download, TrendingUp, TrendingDown } from 'lucide-vue-next'

const activeTab = ref('overview')
const tabs = [
  { id: 'overview', name: 'Overview' },
  { id: 'quality', name: 'Data Quality' },
  { id: 'preview', name: 'Data Preview' },
  { id: 'alerts', name: 'Alerts' }
]
</script>
