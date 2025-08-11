<!-- layouts/default.vue -->
<template>
  <div class="flex h-screen bg-gray-100 text-gray-800">
    <!-- Sidebar -->
    <aside v-if="user" class="w-64 bg-white shadow-md p-6 flex flex-col">
      <div class="text-2xl font-bold mb-10 flex items-center gap-2">
        <IconPieChart class="w-6 h-6" />
        DataInsight
      </div>
      <nav class="flex flex-col gap-4 text-sm">
        <NuxtLink to="/" class="flex items-center gap-2 hover:text-blue-600"><IconHome class="w-4 h-4" /> Dashboard</NuxtLink>
        <NuxtLink to="/upload" class="flex items-center gap-2 hover:text-blue-600"><IconUpload class="w-4 h-4" /> Upload Data</NuxtLink>
        <NuxtLink to="/ColumnMapping" class="flex items-center gap-2 hover:text-blue-600"><IconSettings class="w-4 h-4" /> Map Columns</NuxtLink>
        <NuxtLink to="/results" class="flex items-center gap-2 hover:text-blue-600"><IconBarChart class="w-4 h-4" /> Analysis Results</NuxtLink>
        <NuxtLink to="/history" class="flex items-center gap-2 hover:text-blue-600"><IconClock class="w-4 h-4" /> File History</NuxtLink>
      </nav>
      <button 
        @click="handleLogout" 
        class="mt-auto flex items-center gap-2 text-sm text-gray-600 hover:text-red-600"
      >
        <IconLogOut class="w-4 h-4" />
        Logout
      </button>
    </aside>

    <!-- Main content -->
    <main class="flex-1 p-8 overflow-y-auto">
      <slot />
    </main>
  </div>
</template>

<script setup>
definePageMeta({
  middleware: ['auth']
})

import { useSupabaseClient, useSupabaseUser } from '#imports'
import {
  Home as IconHome,
  Upload as IconUpload,
  Settings as IconSettings,
  BarChart as IconBarChart,
  Clock as IconClock,
  PieChart as IconPieChart,
  LogOut as IconLogOut
} from 'lucide-vue-next'

const user = useSupabaseUser()
const supabase = useSupabaseClient()

async function handleLogout() {
  await supabase.auth.signOut()
  navigateTo('/auth/login')
}
</script>
