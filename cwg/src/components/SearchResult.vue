<template>
  <div class="space-y-4">
    <p v-if="!results.length" class="text-center text-gray-500 py-10">
      Hasil pencarian akan muncul di sini.
    </p>
    <div
      v-for="(item, i) in results"
      :key="i"
      class="bg-gray-50 border p-4 rounded shadow"
    >
      <h3 class="font-semibold text-blue-600 text-lg mb-2">Baris Naskah</h3>
      <p class="mt-2">
        <strong class="text-gray-700">Alih Aksara:</strong><br />
        <span v-html="highlight(item.transliterasi)"></span>
      </p>
      <p class="mt-2">
        <strong class="text-gray-700">Terjemahan Indonesia:</strong><br />
        <span v-html="highlight(item.terjemahan)"></span>
      </p>
    </div>
  </div>
</template>

<script setup>
defineProps({
  results: Array,
  keyword: String
})

const highlight = (text) => {
  if (!text || !keyword) return text
  const safeKeyword = keyword.replace(/[-/\\^$*+?.()|[\]{}]/g, '\\$&')
  const regex = new RegExp(`(${safeKeyword})`, 'gi')
  return text.replace(regex, '<strong>$1</strong>')
}
</script>
