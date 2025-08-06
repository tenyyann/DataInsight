<template>
  <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
    <!-- Analysis Summary -->
    <div class="bg-white p-6 rounded-lg border border-gray-200">
      <h2 class="text-lg font-semibold mb-2">Analysis Summary</h2>
      <p class="text-sm text-gray-500 mb-6">Key findings from your dataset</p>

      <div class="space-y-4">
        <div class="space-y-3">
          <div class="flex justify-between">
            <span class="text-sm text-gray-600">Records Processed</span>
            <span class="text-sm font-medium">1,250 / 1,250</span>
          </div>
          <div class="w-full bg-gray-900 h-2 rounded-full"></div>
        </div>
        <div class="flex justify-between py-3 border-b border-gray-100">
          <span class="text-sm text-gray-600">Valid Records</span>
          <span class="text-sm font-medium">1,182 (94.5%)</span>
        </div>
        <div class="flex justify-between py-3 border-b border-gray-100">
          <span class="text-sm text-gray-600">Invalid Records</span>
          <span class="text-sm font-medium">68 (5.5%)</span>
        </div>
        <div class="flex justify-between py-3">
          <span class="text-sm text-gray-600">Duplicate Records</span>
          <span class="text-sm font-medium">15 (1.2%)</span>
        </div>
      </div>
    </div>

    <!-- Processing Timeline -->
    <div class="bg-white p-6 rounded-lg border border-gray-200">
      <h2 class="text-lg font-semibold mb-2">Processing Timeline</h2>
      <p class="text-sm text-gray-500 mb-6">Analysis completion progress</p>

      <div class="space-y-6">
        <div class="flex items-center gap-3">
          <div class="w-2 h-2 rounded-full bg-green-500"></div>
          <span class="text-sm text-gray-600">File Upload - Completed</span>
        </div>
        <div class="flex items-center gap-3">
          <div class="w-2 h-2 rounded-full bg-green-500"></div>
          <span class="text-sm text-gray-600">Column Mapping - Completed</span>
        </div>
        <div class="flex items-center gap-3">
          <div class="w-2 h-2 rounded-full bg-green-500"></div>
          <span class="text-sm text-gray-600">Data Validation - Completed</span>
        </div>
        <div class="flex items-center gap-3">
          <div class="w-2 h-2 rounded-full bg-green-500"></div>
          <span class="text-sm text-gray-600">Statistical Analysis - Completed</span>
        </div>
        <div class="flex items-center gap-3">
          <div class="w-2 h-2 rounded-full bg-blue-500"></div>
          <span class="text-sm text-gray-600">Report Generation - In Progress</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
defineComponent({
  name: 'ResultsOverview'
})
</script>