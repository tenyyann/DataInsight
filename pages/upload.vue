<template>
  <div class="p-8">
    <div class="flex items-center mb-1">
      <h1 class="text-2xl font-semibold">Upload Data</h1>
      <button class="ml-auto">
        <Copy class="w-5 h-5 text-gray-600" />
      </button>
    </div>
    <p class="text-gray-500 text-sm mb-8">Upload your CSV or Excel files for analysis</p>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
      <!-- Left Column -->
      <div class="bg-white p-6 rounded-lg border border-gray-200">
        <h2 class="text-lg font-semibold mb-2">File Upload</h2>
        <p class="text-gray-500 text-sm mb-6">Select a CSV or Excel file to upload for analysis</p>

        <p class="text-sm font-medium text-gray-700 mb-2">Select File</p>

        <div 
          class="border-2 border-dashed border-gray-200 rounded-lg p-12 text-center cursor-pointer bg-gray-50 hover:bg-gray-100"
          @click="triggerFileInput"
          @dragover.prevent
          @drop.prevent="handleFileDrop"
        >
          <div class="flex flex-col items-center">
            <UploadCloud class="w-12 h-12 mb-4 text-gray-400" />
            <p class="text-sm text-gray-700 mb-1">Click to upload</p>
            <p class="text-sm text-gray-500">or drag and drop</p>
            <p class="text-xs text-gray-400 mt-2">CSV or Excel files only</p>
          </div>
          <input
            ref="fileInput"
            type="file"
            class="hidden"
            accept=".csv, .xls, .xlsx"
            @change="handleFileChange"
            @click.stop
          />
        </div>

        <!-- Affichage du fichier sélectionné -->
        <div v-if="selectedFile" class="mt-4 p-4 bg-gray-50 rounded-lg flex items-center justify-between">
          <div class="flex items-center gap-2">
            <div class="text-sm text-gray-900">{{ selectedFile.name }}</div>
            <div class="text-xs text-gray-500">{{ formatFileSize(selectedFile.size) }}</div>
          </div>
          <button @click.stop="removeFile" class="text-gray-400 hover:text-gray-600">
            <XIcon class="w-4 h-4" />
          </button>
        </div>

        <!-- Champ de description -->
        <div class="mt-6">
          <label class="block text-sm font-medium text-gray-700 mb-2">Description (Optional)</label>
          <textarea
            v-model="description"
            rows="6"
            class="w-full border border-gray-200 rounded-lg p-3 text-sm resize-none"
            placeholder="Add a description for this dataset..."
          ></textarea>
        </div>

        <button
          @click="uploadFile"
          class="w-full mt-6 bg-gray-600 text-white py-2.5 rounded-lg hover:bg-gray-700 transition text-sm font-medium"
        >
          Upload File
        </button>
      </div>

      <!-- Right Column -->
      <div class="bg-white p-6 rounded-lg border border-gray-200">
        <h2 class="text-lg font-semibold mb-4">Upload Guidelines</h2>
        <div class="space-y-6">
          <div>
            <h3 class="text-sm font-medium text-gray-700 mb-2">Supported Formats</h3>
            <p class="text-sm text-gray-500">CSV (.csv), Excel (.xlsx, .xls)</p>
          </div>

          <div>
            <h3 class="text-sm font-medium text-gray-700 mb-2">File Size Limit</h3>
            <p class="text-sm text-gray-500">Maximum file size: 100MB</p>
          </div>

          <div>
            <h3 class="text-sm font-medium text-gray-700 mb-2">Data Quality Tips</h3>
            <ul class="text-sm text-gray-500 list-disc pl-5 space-y-1">
              <li>Include column headers in the first row</li>
              <li>Avoid empty rows or columns</li>
              <li>Use consistent date formats</li>
              <li>Remove special characters from headers</li>
            </ul>
          </div>

          <div>
            <h3 class="text-sm font-medium text-gray-700 mb-2">Data Privacy</h3>
            <p class="text-sm text-gray-500">
              Your data is encrypted and stored securely. We never share your data with third parties.
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { Copy, UploadCloud, X as XIcon } from 'lucide-vue-next'

const fileInput = ref(null)
const selectedFile = ref(null)
const description = ref('')

function triggerFileInput() {
  fileInput.value.click()
}

function handleFileChange(event) {
  event.stopPropagation()
  selectedFile.value = event.target.files[0]
}

function handleFileDrop(event) {
  const file = event.dataTransfer.files[0]
  if (file && (file.type === 'text/csv' || file.type.includes('excel'))) {
    selectedFile.value = file
  }
}

function removeFile() {
  selectedFile.value = null
  description.value = ''
}

function formatFileSize(bytes) {
  if (bytes === 0) return '0 KB'
  const k = 1024
  const sizes = ['B', 'KB', 'MB', 'GB']
  const i = Math.floor(Math.log(bytes) / Math.log(k))
  return `${parseFloat((bytes / Math.pow(k, i)).toFixed(1))} ${sizes[i]}`
}

function uploadFile() {
  if (!selectedFile.value) {
    alert('Please select a file to upload.')
    return
  }
  console.log('File:', selectedFile.value)
  console.log('Description:', description.value)
}
</script>