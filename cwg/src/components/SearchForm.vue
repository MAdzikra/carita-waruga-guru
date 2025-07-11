<template>
  <form @submit.prevent="submit" class="flex items-center space-x-2 w-full">
    <input
      v-model="keyword"
      type="text"
      placeholder="Contoh: 'guru'"
      class="flex-grow p-3 border border-gray-300 rounded-lg bg-white text-gray-800"
    />
    <button
      type="submit"
      class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-3 px-6 rounded-lg"
    >
      Cari
    </button>
  </form>
</template>

<script setup>
import { ref, watchEffect } from 'vue'

const emit = defineEmits(['submit'])
const keyword = ref('')

const submit = () => {
  if (!keyword.value.trim()) return alert('Masukkan kata kunci.')
  emit('submit', keyword.value)
}
</script>
