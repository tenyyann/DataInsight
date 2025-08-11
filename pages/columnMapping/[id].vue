<template>
  <div class="p-8">
    <div class="flex justify-between items-center mb-8">
      <div>
        <h1 class="text-2xl font-bold">Column Mapping</h1>
        <p class="text-gray-500">Map your file columns to standard fields for better analysis</p>
      </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <!-- Left Panel - File Information -->
      <div class="bg-white p-6 rounded-lg shadow-sm">
        <div class="mb-6">
          <h2 class="text-lg font-semibold mb-2">File Information</h2>
        </div>
        <div class="space-y-4">
          <div>
            <label class="text-sm text-gray-500 block">File Name</label>
            <p class="text-sm font-medium">{{ fileInfo.name }}</p>
          </div>
          <div>
            <label class="text-sm text-gray-500 block">Total Rows</label>
            <p class="text-sm font-medium">{{ fileInfo.totalRows }} rows</p>
          </div>
          <div>
            <label class="text-sm text-gray-500 block">Total Columns</label>
            <p class="text-sm font-medium">{{ fileInfo.totalColumns }} columns</p>
          </div>
          <div>
            <label class="text-sm text-gray-500 block">File Size</label>
            <p class="text-sm font-medium">{{ fileInfo.fileSize }}</p>
          </div>
        </div>
      </div>

      <!-- Right Panel - Column Mapping -->
      <div class="lg:col-span-2">
        <div class="bg-white rounded-lg shadow-sm">
          <div class="p-6 border-b">
            <h2 class="text-lg font-semibold">Column Mapping</h2>
            <p class="text-sm text-gray-500">Map each column to a standard field type. Toggle columns you want to include in the analysis.</p>
          </div>

          <div class="overflow-x-auto">
            <table class="w-full">
              <thead class="bg-gray-50 border-b">
                <tr>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Include</th>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Column Name</th>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Sample Data</th>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Detected Type</th>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Confidence</th>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Map to Field</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-200">
                <tr v-for="column in fileInfo.columns" :key="column.name">
                  <td class="px-6 py-4">
                    <label class="relative inline-block w-12 h-6">
                      <input
                        type="checkbox"
                        v-model="column.included"
                        class="hidden"
                      >
                      <span
                        class="absolute cursor-pointer inset-0 rounded-full transition-all duration-300"
                        :class="column.included ? 'bg-blue-600' : 'bg-gray-900'"
                      >
                        <span
                          class="absolute left-1 top-1 w-4 h-4 bg-white rounded-full transition-transform duration-300 shadow-sm"
                          :class="{ 'translate-x-6': column.included }"
                        ></span>
                      </span>
                    </label>
                  </td>
                  <td class="px-6 py-4 text-sm">{{ column.name }}</td>
                  <td class="px-6 py-4 text-sm text-gray-600">{{ column.sampleData }}</td>
                  <td class="px-6 py-4 text-sm">{{ column.detectedType }}</td>
                  <td class="px-6 py-4">
                    <span :class="['px-2 py-1 text-xs rounded-full', column.confidence >= 90 ? 'bg-green-100 text-green-800' : column.confidence >= 70 ? 'bg-yellow-100 text-yellow-800' : 'bg-red-100 text-red-800']">
                      {{ column.confidence }}%
                    </span>
                  </td>
                  <td class="px-6 py-4">
                    <select 
                      v-model="column.mappedField" 
                      :disabled="!column.included"
                      class="form-select text-sm border-gray-300 rounded-md w-full transition-colors duration-200"
                      :class="!column.included ? 'bg-gray-100 text-gray-400 cursor-not-allowed' : 'bg-white'"
                    >
                      <option value="">Select field</option>
                      <optgroup label="Personal Information">
                        <option value="firstName">First Name</option>
                        <option value="lastName">Last Name</option>
                        <option value="fullName">Full Name</option>
                        <option value="email">Email Address</option>
                        <option value="phone">Phone Number</option>
                        <option value="address">Address</option>
                      </optgroup>
                      <optgroup label="Demographics">
                        <option value="age">Age</option>
                        <option value="gender">Gender</option>
                        <option value="birthDate">Birth Date</option>
                        <option value="country">Country</option>
                        <option value="city">City</option>
                      </optgroup>
                      <optgroup label="Business">
                        <option value="company">Company Name</option>
                        <option value="jobTitle">Job Title</option>
                        <option value="department">Department</option>
                        <option value="employeeId">Employee ID</option>
                      </optgroup>
                      <optgroup label="Financial">
                        <option value="amount">Amount</option>
                        <option value="price">Price</option>
                        <option value="revenue">Revenue</option>
                        <option value="cost">Cost</option>
                        <option value="currency">Currency</option>
                      </optgroup>
                      <optgroup label="Temporal">
                        <option value="date">Date</option>
                        <option value="timestamp">Timestamp</option>
                        <option value="startDate">Start Date</option>
                        <option value="endDate">End Date</option>
                        <option value="createdAt">Created At</option>
                        <option value="updatedAt">Updated At</option>
                      </optgroup>
                      <optgroup label="Other">
                        <option value="id">ID</option>
                        <option value="category">Category</option>
                        <option value="status">Status</option>
                        <option value="notes">Notes</option>
                        <option value="description">Description</option>
                        <option value="url">URL</option>
                        <option value="custom">Custom</option>
                      </optgroup>
                    </select>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Mapping Summary -->
        <div class="mt-6 bg-white rounded-lg p-6">
          <h3 class="text-base font-medium mb-2">Mapping Summary</h3>
          <p class="text-sm text-gray-500 mb-6">Review your column mappings before proceeding</p>
          
          <div class="grid grid-cols-3 border border-gray-200 rounded-lg divide-x">
            <div class="p-4 text-center">
              <div class="text-2xl font-semibold text-gray-900">
                {{ fileInfo.columns.filter(c => c.included).length }}
              </div>
              <div class="text-sm text-gray-600">Columns Included</div>
            </div>
            <div class="p-4 text-center">
              <div class="text-2xl font-semibold text-gray-900">
                {{ fileInfo.columns.filter(c => c.mappedField).length }}
              </div>
              <div class="text-sm text-gray-600">Columns Mapped</div>
            </div>
            <div class="p-4 text-center">
              <div class="text-2xl font-semibold text-gray-900">
                {{ fileInfo.totalRows }}
              </div>
              <div class="text-sm text-gray-600">Rows to Process</div>
            </div>
          </div>

          <div class="mt-4 flex items-center text-sm text-gray-500">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            Unmapped columns will be excluded from analysis
          </div>

          <div class="mt-6 flex justify-end space-x-3">
            <button 
              @click="handleCancel" 
              class="px-4 py-2 text-sm text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50"
            >
              Cancel
            </button>
            <button 
              @click="proceedToAnalysis"
              class="px-4 py-2 text-sm text-white bg-blue-600 rounded-lg hover:bg-blue-700"
            >
              Proceed to Analysis
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from '#imports'
import { useSupabaseClient } from '#imports'
import * as XLSX from 'xlsx'

const route = useRoute()
const router = useRouter()
const supabase = useSupabaseClient()

const fileInfo = ref({
  name: '',
  totalRows: 0,
  totalColumns: 0,
  fileSize: '',
  columns: []
})

// Add loading state
const isLoading = ref(true)

// Function to get confidence class
function getConfidenceClass(confidence) {
  if (confidence >= 90) return 'bg-green-100 text-green-800'
  if (confidence >= 70) return 'bg-yellow-100 text-yellow-800'
  return 'bg-red-100 text-red-800'
}

// Add missing utility functions
function detectColumnType(values) {
  // Get first non-empty value as sample
  const sample = values.find(v => v && v.trim()) || ''
  
  // Check if number
  if (!isNaN(sample) && sample.trim() !== '') {
    return 'Number'
  }
  
  // Check if date
  const dateRegex = /^\d{4}-\d{2}-\d{2}|^\d{2}[/-]\d{2}[/-]\d{4}/
  if (dateRegex.test(sample) || !isNaN(Date.parse(sample))) {
    return 'Date'
  }
  
  // Check if email
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (emailRegex.test(sample)) {
    return 'Email'
  }
  
  return 'Text'
}

function calculateConfidence(values) {
  const totalValues = values.length
  if (totalValues === 0) return 0

  const validValues = values.filter(v => v && v.trim()).length
  return Math.round((validValues / totalValues) * 100)
}

function formatFileSize(bytes) {
  if (!bytes) return '0 B'
  const sizes = ['B', 'KB', 'MB', 'GB']
  const i = Math.floor(Math.log(bytes) / Math.log(1024))
  return `${Math.round(bytes / Math.pow(1024, i))} ${sizes[i]}`
}

async function fetchFileData() {
  try {
    isLoading.value = true
    console.log('Fetching file with ID:', route.params.id)

    const { data: fileRecord, error: fileError } = await supabase
      .from('files')
      .select('*')
      .eq('id', route.params.id)
      .single()

    console.log('File record:', fileRecord)
    console.log('File error:', fileError)

    if (fileError) {
      console.error('Database error:', fileError)
      throw new Error('Could not find file record')
    }

    if (!fileRecord) {
      throw new Error('File record not found')
    }

    // For Excel files, we need to use a different approach
    if (fileRecord.name.endsWith('.xlsx')) {
      const { data: fileContent, error: storageError } = await supabase.storage
        .from('datainsight')
        .download(fileRecord.file_path)

      if (storageError) {
        console.error('Storage error:', storageError)
        throw new Error('Could not download file content')
      }

      // Use xlsx library to parse Excel file
      const workbook = await readExcelFile(fileContent)
      const firstSheet = workbook.Sheets[workbook.SheetNames[0]]
      const jsonData = XLSX.utils.sheet_to_json(firstSheet, { header: 1 })

      const headers = jsonData[0]
      const sampleData = jsonData.slice(1, Math.min(6, jsonData.length))

      console.log('Excel headers:', headers)
      console.log('Excel sample data:', sampleData)

      const columns = headers.map((header, index) => {
        const columnValues = sampleData.map(row => row[index]?.toString().trim() || '')
        
        return {
          name: header || `Column ${index + 1}`,
          sampleData: columnValues[0] || '',
          detectedType: detectColumnType(columnValues),
          confidence: calculateConfidence(columnValues),
          included: true,
          mappedField: ''
        }
      })

      fileInfo.value = {
        name: fileRecord.name,
        totalRows: jsonData.length - 1,
        totalColumns: headers.length,
        fileSize: formatFileSize(fileRecord.file_size),
        columns
      }
    }

    console.log('Final file info:', fileInfo.value)

  } catch (error) {
    console.error('Error in fetchFileData:', error)
    alert(error.message || 'Error loading file data')
  } finally {
    isLoading.value = false
  }
}

// Add Excel file reading function
async function readExcelFile(file) {
  const arrayBuffer = await file.arrayBuffer()
  const workbook = XLSX.read(arrayBuffer, { type: 'array' })
  return workbook
}

// Handle proceed to analysis
async function proceedToAnalysis() {
  try {
    const mappedColumns = fileInfo.value.columns
      .filter(col => col.included)
      .map(col => ({
        name: col.name,
        mappedField: col.mappedField,
        type: col.detectedType
      }))

    // Save column mapping to database
    const { error } = await supabase
      .from('files')
      .update({
        column_mapping: mappedColumns,
        status: 'mapped'
      })
      .eq('id', route.params.id)

    if (error) throw error

    // Navigate to analysis page
    router.push(`/analysis/${route.params.id}`)
  } catch (error) {
    console.error('Error saving mapping:', error)
    alert('Error saving column mapping')
  }
}

// Handle cancel
function handleCancel() {
  router.push('/upload')
}

onMounted(fetchFileData)
</script>

<style scoped>
.form-select {
  background-position: right 0.5rem center;
  background-repeat: no-repeat;
  background-size: 1.5em 1.5em;
  padding-right: 2.5rem;
}

.form-select:disabled {
  opacity: 0.7;
}
</style>

-- Run in Supabase SQL editor
create policy "Allow authenticated downloads"
on storage.objects for select
to authenticated
using (bucket_id = 'datainsight');