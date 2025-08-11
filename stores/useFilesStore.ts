import { defineStore } from '#imports'

export const useFilesStore = defineStore('files', {
  state: () => ({
    files: [],
    isLoading: false,
    error: null
  }),

  actions: {
    async fetchUserFiles() {
      const supabase = useSupabaseClient()
      this.isLoading = true
      
      try {
        const { data, error } = await supabase
          .from('files')
          .select('*')
          .order('created_at', { ascending: false })

        if (error) throw error
        this.files = data
      } catch (error) {
        this.error = error.message
      } finally {
        this.isLoading = false
      }
    },

    async addFile(fileData) {
      const supabase = useSupabaseClient()
      
      try {
        const { data, error } = await supabase
          .from('files')
          .insert(fileData)
          .select()
          .single()

        if (error) throw error
        this.files.unshift(data)
      } catch (error) {
        this.error = error.message
      }
    }
  },

  getters: {
    recentFiles: (state) => state.files.slice(0, 5),
    filesByStatus: (state) => (status) => 
      state.files.filter(file => file.status === status)
  }
})