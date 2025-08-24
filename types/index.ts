export interface AnalysisResult {
  id: string
  fileId: string
  results: {
    summary: {
      rowCount: number
      columnCount: number
      dataQualityScore: number
    }
    columns: Array<{
      name: string
      type: string
      statistics: {
        nullCount: number
        uniqueCount: number
        min?: number | string
        max?: number | string
        mean?: number
      }
    }>
    insights: Array<{
      type: string
      description: string
      severity: 'low' | 'medium' | 'high'
    }>
  }
  createdAt: Date
  updatedAt: Date
}

export interface ProcessedFile {
  id: string
  name: string
  status: 'uploaded' | 'processing' | 'completed' | 'error'
  errorMessage?: string
  filePath: string
  fileSize: number
  columnMapping: Array<{
    originalName: string
    mappedField: string
    type: string
  }>
  userId: string
  createdAt: Date
}