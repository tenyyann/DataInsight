<template>
  <div class="bg-white p-6 rounded-lg border border-gray-200">
    <h2 class="text-2xl font-semibold mb-2">Data Quality Assessment</h2>
    <p class="text-gray-500 text-sm mb-8">Comprehensive evaluation of your data quality</p>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
      <!-- Left Column -->
      <div class="space-y-8">
        <div>
          <div class="flex justify-between items-center mb-2">
            <span class="text-sm font-medium text-gray-700">Completeness</span>
            <span class="text-sm font-medium text-green-600">92/100</span>
          </div>
          <div class="w-full bg-gray-100 rounded-full h-2.5">
            <div class="bg-gray-900 h-2.5 rounded-full" style="width: 92%"></div>
          </div>
          <p class="text-sm text-gray-500 mt-2">Percentage of non-null values</p>
        </div>

        <div>
          <div class="flex justify-between items-center mb-2">
            <span class="text-sm font-medium text-gray-700">Consistency</span>
            <span class="text-sm font-medium text-yellow-600">85/100</span>
          </div>
          <div class="w-full bg-gray-100 rounded-full h-2.5">
            <div class="bg-gray-900 h-2.5 rounded-full" style="width: 85%"></div>
          </div>
          <p class="text-sm text-gray-500 mt-2">Data pattern consistency</p>
        </div>
      </div>

      <!-- Right Column -->
      <div class="space-y-8">
        <div>
          <div class="flex justify-between items-center mb-2">
            <span class="text-sm font-medium text-gray-700">Validity</span>
            <span class="text-sm font-medium text-yellow-600">88/100</span>
          </div>
          <div class="w-full bg-gray-100 rounded-full h-2.5">
            <div class="bg-gray-900 h-2.5 rounded-full" style="width: 88%"></div>
          </div>
          <p class="text-sm text-gray-500 mt-2">Data format compliance</p>
        </div>

        <div>
          <div class="flex justify-between items-center mb-2">
            <span class="text-sm font-medium text-gray-700">Accuracy</span>
            <span class="text-sm font-medium text-green-600">90/100</span>
          </div>
          <div class="w-full bg-gray-100 rounded-full h-2.5">
            <div class="bg-gray-900 h-2.5 rounded-full" style="width: 90%"></div>
          </div>
          <p class="text-sm text-gray-500 mt-2">Data correctness estimation</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
defineComponent({
  name: 'ResultsDataQuality'
})
</script>