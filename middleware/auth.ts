export default defineNuxtRouteMiddleware((to) => {
  const user = useSupabaseUser()

  // Liste des routes publiques
  const publicRoutes = ['/login', '/register']

  if (!user.value && !publicRoutes.includes(to.path)) {
    return navigateTo('/login')
  }
})