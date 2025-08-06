<template>
  <div class="bg-white p-6 rounded-lg border border-gray-200">
    <h2 class="text-2xl font-semibold mb-2">Data Preview</h2>
    <p class="text-gray-500 text-sm mb-8">Sample of your processed data (showing first 4 rows)</p>

    <div class="overflow-x-auto">
      <table class="min-w-full table-auto">
        <thead>
          <tr class="border-b border-gray-100">
            <th class="py-3 text-left text-sm font-medium text-gray-600">Name</th>
            <th class="py-3 text-left text-sm font-medium text-gray-600">Email</th>
            <th class="py-3 text-left text-sm font-medium text-gray-600">Age</th>
            <th class="py-3 text-left text-sm font-medium text-gray-600">Revenue</th>
            <th class="py-3 text-left text-sm font-medium text-gray-600">Category</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="row in previewData" :key="row.email" class="border-b border-gray-50">
            <td class="py-4 text-sm text-gray-900">{{ row.name }}</td>
            <td class="py-4 text-sm text-blue-600">{{ row.email }}</td>
            <td class="py-4 text-sm text-gray-900">{{ row.age }}</td>
            <td class="py-4 text-sm text-gray-900">${{ row.revenue.toLocaleString() }}</td>
            <td class="py-4">
              <span :class="getCategoryClass(row.category)">
                {{ row.category }}
              </span>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { defineComponent } from 'vue'

const previewData = [
  {
    name: 'John Doe',
    email: 'john@example.com',
    age: 25,
    revenue: 5200,
    category: 'Premium'
  },
  {
    name: 'Jane Smith',
    email: 'jane@example.com',
    age: 32,
    revenue: 3800,
    category: 'Standard'
  },
  {
    name: 'Bob Johnson',
    email: 'bob@example.com',
    age: 28,
    revenue: 4100,
    category: 'Premium'
  },
  {
    name: 'Alice Brown',
    email: 'alice@example.com',
    age: 35,
    revenue: 2900,
    category: 'Basic'
  }
]

function getCategoryClass(category) {
  const baseClasses = 'px-2 py-1 text-xs font-medium rounded-full'
  switch (category.toLowerCase()) {
    case 'premium':
      return `${baseClasses} bg-purple-100 text-purple-700`
    case 'standard':
      return `${baseClasses} bg-blue-100 text-blue-700`
    case 'basic':
      return `${baseClasses} bg-gray-100 text-gray-700`
    default:
      return `${baseClasses} bg-gray-100 text-gray-700`
  }
}
</script>