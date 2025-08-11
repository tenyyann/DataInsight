<template>
  <div class="max-w-md mx-auto p-6 bg-white rounded-lg shadow-md">
    <h2 class="text-2xl font-bold mb-6">Login to DataInsight</h2>
    <form @submit.prevent="handleLogin" class="space-y-4">
      <div>
        <label class="block text-sm font-medium text-gray-700">Email</label>
        <input 
          v-model="email" 
          type="email" 
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
          required
        >
      </div>
      <div>
        <label class="block text-sm font-medium text-gray-700">Password</label>
        <input 
          v-model="password" 
          type="password" 
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
          required
        >
      </div>
      <button 
        type="submit" 
        class="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700"
        :disabled="loading"
      >
        {{ loading ? 'Loading...' : 'Sign In' }}
      </button>
    </form>
  </div>
</template>

<script setup>
const client = useSupabaseClient()
const user = useSupabaseUser()

const email = ref('')
const password = ref('')
const loading = ref(false)

async function handleLogin() {
  try {
    loading.value = true
    const { error } = await client.auth.signInWithPassword({
      email: email.value,
      password: password.value
    })
    if (error) throw error
  } catch (error) {
    console.error('Error:', error.message)
  } finally {
    loading.value = false
  }
}
</script>