<template>
  <div class="p-8">
    <div class="mb-8">
      <h1 class="text-2xl font-bold">Analysis Results</h1>
      <p class="text-gray-500">Viewing results for file: {{ file?.name }}</p>
    </div>

    <div v-if="loading" class="text-center py-12">
      <div class="animate-spin h-8 w-8 mx-auto mb-4 border-4 border-blue-600 border-t-transparent rounded-full"></div>
      <p class="text-gray-600">Processing your file...</p>
    </div>

    <div v-else-if="error" class="bg-red-50 p-4 rounded-lg">
      <p class="text-red-600">{{ error }}</p>
    </div>

    <div v-else class="grid gap-6">
      <!-- File Summary -->
      <div class="bg-white p-6 rounded-lg shadow-sm">
        <h2 class="text-lg font-semibold mb-4">File Summary</h2>
        <div class="grid grid-cols-3 gap-4">
          <div>
            <p class="text-sm text-gray-500">Total Rows</p>
            <p class="text-2xl font-medium">{{ analysisResult?.results.summary.rowCount }}</p>
          </div>
          <div>
            <p class="text-sm text-gray-500">Total Columns</p>
            <p class="text-2xl font-medium">{{ analysisResult?.results.summary.columnCount }}</p>
          </div>
          <div>
            <p class="text-sm text-gray-500">Quality Score</p>
            <p class="text-2xl font-medium">{{ analysisResult?.results.summary.dataQualityScore }}%</p>
          </div>
        </div>
      </div>

      <!-- Column Analysis -->
      <div class="bg-white p-6 rounded-lg shadow-sm">
        <h2 class="text-lg font-semibold mb-4">Column Analysis</h2>
        <div class="overflow-x-auto">
          <table class="w-full">
            <thead class="bg-gray-50">
              <tr>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Column Name</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Type</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Null Count</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Unique Count</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Min</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Max</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
              <tr v-for="column in analysisResult?.results.columns" :key="column.name">
                <td class="px-6 py-4 text-sm">{{ column.name }}</td>
                <td class="px-6 py-4 text-sm">{{ column.type }}</td>
                <td class="px-6 py-4 text-sm">{{ column.statistics.nullCount }}</td>
                <td class="px-6 py-4 text-sm">{{ column.statistics.uniqueCount }}</td>
                <td class="px-6 py-4 text-sm">{{ column.statistics.min }}</td>
                <td class="px-6 py-4 text-sm">{{ column.statistics.max }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Insights -->
      <div class="bg-white p-6 rounded-lg shadow-sm">
        <h2 class="text-lg font-semibold mb-4">Data Insights</h2>
        <div class="space-y-4">
          <div v-for="insight in analysisResult?.results.insights" 
               :key="insight.description"
               class="p-4 rounded-lg"
               :class="{
                 'bg-red-50': insight.severity === 'high',
                 'bg-yellow-50': insight.severity === 'medium',
                 'bg-blue-50': insight.severity === 'low'
               }">
            <p class="font-medium mb-1">{{ insight.type }}</p>
            <p class="text-sm text-gray-600">{{ insight.description }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from '#imports'
import type { AnalysisResult, ProcessedFile } from '~/types'

const route = useRoute()
const supabase = useSupabaseClient()

const loading = ref(true)
const error = ref<string | null>(null)
const file = ref<ProcessedFile | null>(null)
const analysisResult = ref<AnalysisResult | null>(null)

onMounted(async () => {
  try {
    const fileId = route.params.id as string

    // Fetch file details
    const { data: fileData, error: fileError } = await supabase
      .from('files')
      .select('*')
      .eq('id', fileId)
      .single()

    if (fileError) throw fileError
    file.value = fileData as ProcessedFile

    // Fetch analysis results
    const { data: analysisData, error: analysisError } = await supabase
      .from('analysis_results')
      .select('*')
      .eq('file_id', fileId)
      .single()

    if (analysisError) throw analysisError
    analysisResult.value = analysisData as AnalysisResult

  } catch (e) {
    error.value = e.message
  } finally {
    loading.value = false
  }
})
</script>