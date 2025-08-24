<template>
  <div class="p-8">
    <div class="flex items-center mb-1">
      <h1 class="text-2xl font-semibold">Column Mapping</h1>
      <button class="ml-auto">
        <Copy class="w-5 h-5 text-gray-600" />
      </button>
    </div>
    <p class="text-gray-500 text-sm mb-8">Map your file columns to standard fields for better analysis</p>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <!-- File Information Card -->
      <div class="bg-white p-6 rounded-lg border border-gray-200">
        <h2 class="text-lg font-semibold mb-4 flex items-center gap-2">
          <FileText class="w-5 h-5" />
          File Information
        </h2>
        <div class="space-y-4">
          <div>
            <div class="text-sm font-medium text-gray-700 mb-1">File Name</div>
            <div class="text-sm text-gray-500">{{ fileName }}</div>
          </div>
          <div>
            <div class="text-sm font-medium text-gray-700 mb-1">Total Rows</div>
            <div class="text-sm text-gray-500">{{ totalRows }} rows</div>
          </div>
          <div>
            <div class="text-sm font-medium text-gray-700 mb-1">Total Columns</div>
            <div class="text-sm text-gray-500">{{ totalColumns }} columns</div>
          </div>
          <div>
            <div class="text-sm font-medium text-gray-700 mb-1">File Size</div>
            <div class="text-sm text-gray-500">{{ fileSize }}</div>
          </div>
        </div>
      </div>

      <!-- Column Mapping Section -->
      <div class="lg:col-span-2 bg-white p-6 rounded-lg border border-gray-200">
        <h2 class="text-lg font-semibold mb-2">Column Mapping</h2>
        <p class="text-gray-500 text-sm mb-6">Map each column to a standard field type. Toggle columns you want to include in the analysis.</p>

        <div class="space-y-4">
          <!-- Table Header -->
          <div class="grid grid-cols-6 gap-4 text-sm font-medium text-gray-700 mb-2">
            <div class="col-span-1">Include</div>
            <div class="col-span-1">Column Name</div>
            <div class="col-span-1">Sample Data</div>
            <div class="col-span-1">Detected Type</div>
            <div class="col-span-1">Confidence</div>
            <div class="col-span-1">Map to Field</div>
          </div>

          <!-- Column Rows -->
          <div v-for="col in columns" :key="col.name" class="grid grid-cols-6 gap-4 items-center py-2 border-t border-gray-100">
            <div class="col-span-1">
              <label class="relative inline-flex items-center cursor-pointer">
                <input type="checkbox" v-model="col.included" class="sr-only peer">
                <div class="w-9 h-5 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-4 after:w-4 after:transition-all peer-checked:bg-gray-600"></div>
              </label>
            </div>
            <div class="col-span-1 text-sm text-gray-900">{{ col.name }}</div>
            <div class="col-span-1 text-sm text-gray-500">{{ col.sampleData }}</div>
            <div class="col-span-1 text-sm text-gray-500">{{ col.detectedType }}</div>
            <div class="col-span-1">
              <span :class="getConfidenceBadgeClass(col.confidence)">
                {{ col.confidence }}%
              </span>
            </div>
            <div class="col-span-1">
              <select 
                v-model="col.mappedField" 
                class="w-full text-sm border border-gray-200 rounded-lg p-2 disabled:bg-gray-100 disabled:text-gray-400 disabled:cursor-not-allowed"
                :disabled="!col.included"
              >
                <option value="">Select field</option>
                <option v-for="field in availableFields" :key="field" :value="field">
                  {{ field }}
                </option>
              </select>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Mapping Summary -->
    <div class="mt-8 bg-white p-6 rounded-lg border border-gray-200">
      <h2 class="text-lg font-semibold mb-4">Mapping Summary</h2>
      <p class="text-gray-500 text-sm mb-6">Review your column mappings before proceeding</p>

      <div class="grid grid-cols-3 gap-8 mb-6">
        <div class="text-center">
          <div class="text-3xl font-semibold text-gray-900">{{ columnsIncluded }}</div>
          <div class="text-sm text-gray-500">Columns Included</div>
        </div>
        <div class="text-center">
          <div class="text-3xl font-semibold text-gray-900">{{ columnsMapped }}</div>
          <div class="text-sm text-gray-500">Columns Mapped</div>
        </div>
        <div class="text-center">
          <div class="text-3xl font-semibold text-gray-900">{{ totalRows }}</div>
          <div class="text-sm text-gray-500">Rows to Process</div>
        </div>
      </div>

      <div class="flex items-center text-sm text-gray-500">
        <AlertCircle class="w-4 h-4 mr-2" />
        Unmapped columns will be excluded from analysis
      </div>

      <button 
        @click="proceedToAnalysis"
        class="mt-6 w-full bg-gray-900 text-white py-2.5 rounded-lg hover:bg-gray-800 transition text-sm font-medium"
      >
        Proceed to Analysis
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { Copy, FileText, AlertCircle } from 'lucide-vue-next'
import { useToast } from 'vue-toastification'
import { useRouter, useSupabaseClient } from '#imports'

// File information
const fileName = ref('sales_data_2024.xlsx')
const totalRows = ref(1250)
const totalColumns = ref(5)
const fileSize = ref('2.4 MB')

// Column data
const columns = ref([
  {
    name: 'col_1',
    sampleData: 'John Doe',
    detectedType: 'Text',
    confidence: 95,
    included: true,
    mappedField: ''
  },
  {
    name: 'col_2',
    sampleData: 'john@example.com',
    detectedType: 'Email',
    confidence: 98,
    included: true,
    mappedField: ''
  },
  {
    name: 'col_3',
    sampleData: '25',
    detectedType: 'Number',
    confidence: 100,
    included: true,
    mappedField: ''
  },
  {
    name: 'col_4',
    sampleData: '2023-01-15',
    detectedType: 'Date',
    confidence: 92,
    included: true,
    mappedField: ''
  },
  {
    name: 'col_5',
    sampleData: 'Notes here',
    detectedType: 'Text',
    confidence: 85,
    included: false,
    mappedField: ''
  }
])

const availableFields = ref([
  'Name',
  'Email',
  'Age',
  'Date',
  'Phone',
  'Address',
  'City',
  'Country',
  'Revenue',
  'Quantity',
  'Price',
  'Category',
  'Status',
  'Description',
  'Custom Field'
])

// Computed values for summary
const columnsIncluded = computed(() => columns.value.filter(col => col.included).length)
const columnsMapped = computed(() => columns.value.filter(col => col.included && col.mappedField).length)

// Utility function for confidence badge styling
function getConfidenceBadgeClass(confidence: number) {
  const baseClasses = 'px-2 py-1 rounded-full text-xs font-medium'
  if (confidence >= 95) {
    return `${baseClasses} bg-green-100 text-green-700`
  } else if (confidence >= 80) {
    return `${baseClasses} bg-yellow-100 text-yellow-700`
  }
  return `${baseClasses} bg-red-100 text-red-700`
}

// Utilisation du toast
const toast = useToast()
const router = useRouter()
const supabase = useSupabaseClient()

async function proceedToAnalysis() {
  try {
    const mappedColumns = columns.value.filter(col => col.included && col.mappedField)
    
    if (mappedColumns.length === 0) {
      toast.error('No columns mapped\nPlease map at least one column to proceed with analysis.', {
        timeout: 3000
      })
      return
    }

    // Sauvegarder le mapping dans Supabase
    const { error: updateError } = await supabase
      .from('files')
      .update({
        column_mapping: mappedColumns,
        status: 'mapped'
      })
      .eq('id', route.params.id)

    if (updateError) throw updateError

    // Créer une entrée d'analyse initiale
    const initialAnalysis = {
      totalRecords: totalRows.value,
      recordsChange: 0,
      averageRevenue: 0,
      revenueChange: 0,
      completionRate: 0,
      completionChange: 0,
      qualityScore: 0,
      qualityChange: 0,
      validRecords: totalRows.value,
      validPercentage: 100,
      invalidRecords: 0,
      invalidPercentage: 0,
      duplicateRecords: 0,
      duplicatePercentage: 0
    }

    // Créer ou mettre à jour l'entrée d'analyse
    const { error: analysisError } = await supabase
      .from('analysis_results')
      .upsert({
        file_id: route.params.id,
        results: initialAnalysis
      })

    if (analysisError) throw analysisError

    toast.success(`Column mapping saved!\n${mappedColumns.length} columns mapped successfully.`, {
      timeout: 2000
    })

    // Rediriger vers results avec l'ID du fichier
    await router.push(`/results?fileId=${route.params.id}`)

  } catch (error) {
    console.error('Error in proceedToAnalysis:', error)
    toast.error('Error saving column mapping: ' + error.message)
  }
}
</script>