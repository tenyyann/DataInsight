<template>
  <div>
    <div class="flex justify-between items-center mb-6">
      <div>
        <h1 class="text-3xl font-bold">Dashboard</h1>
        <p class="text-gray-600 mt-1">Welcome back! Here's an overview of your data analytics.</p>
      </div>
      <button class="bg-gray-900 text-white px-4 py-2 rounded-lg flex items-center gap-2 hover:bg-black">
        <IconUpload class="w-4 h-4" /> Upload New File
      </button>
    </div>

<div class="grid grid-cols-4 gap-4 mb-6">
  <StatCard :icon="FileText" title="Total Files Analyzed" value="24" percentage="+12%" :isPositive="true" />
  <StatCard title="Data Points Processed" value="1.2M" percentage="+8%" :icon="BarChart" :isPositive="true"/>
  <StatCard title="Active Projects" value="8" percentage="-3%" :icon="SquareKanban" :isPositive="false" /> 
  <StatCard title="Team Members" value="12" percentage="0%" :icon="Users" :isPositive="true" />


</div>


    <div class="grid grid-cols-2 gap-4">
      <RecentFiles />
      <QuickActions />
    </div>
  </div>
</template>

<script setup>
import { FileText, Upload, Settings , BarChart , SquareKanban, Users } from 'lucide-vue-next'
import StatCard from '~/components/Dashboard/StatCard.vue'
import RecentFiles from '~/components/Dashboard/RecentFiles.vue'
import QuickActions from '~/components/Dashboard/QuickActions.vue'

</script>
