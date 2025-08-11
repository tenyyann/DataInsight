<template>
  <div class="bg-white rounded-lg shadow-sm p-6">
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-lg font-semibold">File History</h2>
      <div class="flex gap-2">
        <button 
          v-for="status in ['all', 'completed', 'processing', 'failed']"
          :key="status"
          @click="currentStatus = status"
          :class="[
            'px-3 py-1 rounded-full text-sm',
            currentStatus === status 
              ? 'bg-blue-100 text-blue-700' 
              : 'bg-gray-100 text-gray-600'
          ]"
        >
          {{ status.charAt(0).toUpperCase() + status.slice(1) }}
        </button>
      </div>
    </div>

    <div class="space-y-4">
      <div v-for="file in filteredFiles" :key="file.id" 
        class="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
        <div class="flex items-center gap-3">
          <FileIcon class="w-5 h-5 text-gray-400" />
          <div>
            <div class="font-medium text-sm">{{ file.name }}</div>
            <div class="text-xs text-gray-500">
              {{ formatDate(file.created_at) }} • {{ formatFileSize(file.file_size) }}
            </div>
          </div>
        </div>
        <div class="flex items-center gap-4">
          <span :class="getStatusClass(file.status)" class="text-xs px-2 py-1 rounded-full">
            {{ file.status }}
          </span>
          <button @click="navigateTo(`/columnMapping/${file.id}`)" 
            class="text-blue-600 hover:text-blue-700 text-sm">
            View Details
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useFilesStore } from '~/stores/useFilesStore'
import { File as FileIcon } from 'lucide-vue-next'

const filesStore = useFilesStore()
const currentStatus = ref('all')

const filteredFiles = computed(() => {
  if (currentStatus.value === 'all') return filesStore.files
  return filesStore.filesByStatus(currentStatus.value)
})

function getStatusClass(status) {
  return {
    'completed': 'bg-green-100 text-green-700',
    'processing': 'bg-blue-100 text-blue-700',
    'failed': 'bg-red-100 text-red-700'
  }[status] || 'bg-gray-100 text-gray-600'
}

onMounted(() => {
  filesStore.fetchUserFiles()
})
</script>