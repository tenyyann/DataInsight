import { FileProcessingService } from '../../services/fileProcessing'

export default defineEventHandler(async (event) => {
  const config = useRuntimeConfig()
  const fileId = event.context.params.id
  
  try {
    const processingService = new FileProcessingService(event.context.supabase)
    const result = await processingService.processFile(fileId)
    
    return {
      status: 'success',
      data: result
    }
  } catch (error) {
    console.error('Analysis error:', error)
    return {
      status: 'error',
      message: error.message
    }
  }
})