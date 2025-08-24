<template>
  <div class="p-8">
    <!-- Header -->
    <div class="flex items-center justify-between mb-1">
      <div>
        <h1 class="text-2xl font-bold mb-1">Analysis Results</h1>
        <p class="text-gray-500 text-sm">Detailed insights from your data analysis</p>
      </div>
      <div class="flex gap-4">
        <button 
          @click="handleViewCharts"
          class="flex items-center gap-2 px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50"
        >
          <Clock class="w-4 h-4" />
          View Charts
        </button>
        <button 
          @click="handleExport"
          class="flex items-center gap-2 px-4 py-2 text-sm font-medium text-white bg-gray-900 rounded-lg hover:bg-gray-800"
        >
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
        <p class="text-2xl font-bold mb-2">{{ analysisData.totalRecords }}</p>
        <p class="text-sm text-green-600">+{{ analysisData.recordsChange }}% from last analysis</p>
      </div>

      <div class="bg-white p-6 rounded-lg border border-gray-200">
        <div class="flex justify-between items-start mb-4">
          <h3 class="text-sm font-medium text-gray-500">Average Revenue</h3>
          <TrendingUp class="w-4 h-4 text-green-500" />
        </div>
        <p class="text-2xl font-bold mb-2">${{ analysisData.averageRevenue }}</p>
        <p class="text-sm text-green-600">+{{ analysisData.revenueChange }}% from last analysis</p>
      </div>

      <div class="bg-white p-6 rounded-lg border border-gray-200">
        <div class="flex justify-between items-start mb-4">
          <h3 class="text-sm font-medium text-gray-500">Completion Rate</h3>
          <TrendingDown class="w-4 h-4 text-red-500" />
        </div>
        <p class="text-2xl font-bold mb-2">{{ analysisData.completionRate }}%</p>
        <p class="text-sm text-red-600">-{{ -analysisData.completionChange }}% from last analysis</p>
      </div>

      <div class="bg-white p-6 rounded-lg border border-gray-200">
        <div class="flex justify-between items-start mb-4">
          <h3 class="text-sm font-medium text-gray-500">Data Quality Score</h3>
          <TrendingUp class="w-4 h-4 text-green-500" />
        </div>
        <p class="text-2xl font-bold mb-2">{{ analysisData.qualityScore }}/100</p>
        <p class="text-sm text-green-600">+{{ analysisData.qualityChange }}% from last analysis</p>
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
import { ref, onMounted } from 'vue'
import { Clock, Download, TrendingUp, TrendingDown } from 'lucide-vue-next'
import { useRoute } from '#imports'
import { useSupabaseClient } from '#imports'

const route = useRoute()
const supabase = useSupabaseClient()

const activeTab = ref('overview')
const tabs = [
  { id: 'overview', name: 'Overview' },
  { id: 'quality', name: 'Data Quality' },
  { id: 'preview', name: 'Data Preview' },
  { id: 'alerts', name: 'Alerts' }
]

// Analysis data state
const analysisData = ref({
  totalRecords: 0,
  recordsChange: 0,
  averageRevenue: 0,
  revenueChange: 0,
  completionRate: 0,
  completionChange: 0,
  qualityScore: 0,
  qualityChange: 0,
  validRecords: 0,
  validPercentage: 0,
  invalidRecords: 0,
  invalidPercentage: 0,
  duplicateRecords: 0,
  duplicatePercentage: 0
})

// Fetch analysis data
onMounted(async () => {
  try {
    const { data: fileData, error: fileError } = await supabase
      .from('files')
      .select('*')
      .eq('id', route.query.fileId)
      .single()

    if (fileError) throw fileError

    const { data: analysisResults, error: analysisError } = await supabase
      .from('analysis_results')
      .select('*')
      .eq('file_id', route.query.fileId)
      .single()

    if (analysisError) throw analysisError

    if (analysisResults) {
      analysisData.value = {
        totalRecords: fileData.total_rows || 1250,
        recordsChange: 12,
        averageRevenue: analysisResults.results?.averageRevenue || 4250,
        revenueChange: 8,
        completionRate: analysisResults.results?.completionRate || 94.5,
        completionChange: -2,
        qualityScore: analysisResults.results?.qualityScore || 87,
        qualityChange: 5,
        validRecords: analysisResults.results?.validRecords || 1182,
        validPercentage: analysisResults.results?.validPercentage || 94.5,
        invalidRecords: analysisResults.results?.invalidRecords || 68,
        invalidPercentage: analysisResults.results?.invalidPercentage || 5.5,
        duplicateRecords: analysisResults.results?.duplicateRecords || 15,
        duplicatePercentage: analysisResults.results?.duplicatePercentage || 1.2
      }
    }
  } catch (error) {
    console.error('Error fetching analysis results:', error)
  }
})

// Export report handler
const handleExport = async () => {
  // TODO: Implement export functionality
  console.log('Exporting report...')
}

// View charts handler
const handleViewCharts = () => {
  // TODO: Implement charts view
  console.log('Viewing charts...')
}
</script>
