<template>
  <div class="bg-gray-100 text-gray-800 min-h-screen flex flex-col">
    <header class="bg-blue-700 text-white shadow-lg sticky top-0 z-50">
      <div class="w-full max-w-6xl mx-auto px-6 py-4">
        <h1 class="text-2xl font-bold">
          Sistem Pencarian Semantik Naskah Sunda Kuno
        </h1>
        <p class="text-lg">Carita Waruga Guru</p>
      </div>
    </header>

    <main class="w-full max-w-6xl mx-auto px-6 py-8 flex-grow">
      <section class="mb-10 p-6 bg-white rounded-xl shadow-xl">
        <h2 class="text-xl font-semibold mb-4 text-blue-700">Cari Naskah</h2>
        <SearchForm @submit="handleSearch" />
      </section>

      <section class="p-6 bg-white rounded-xl shadow-xl">
        <h2 class="text-xl font-semibold mb-4 text-blue-700">Hasil Pencarian</h2>
        <SearchResult :results="hasil" :keyword="kataKunci" />
      </section>
    </main>

    <footer class="bg-gray-800 text-white text-center py-4 mt-10">
      <p>
        &copy; {{ tahun }} - Proyek Pencarian Semantik Carita Waruga Guru
      </p>
    </footer>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import SearchForm from './components/SearchForm.vue'
import SearchResult from './components/SearchResult.vue'

const hasil = ref([])
const kataKunci = ref('')
const tahun = new Date().getFullYear()

const handleSearch = async (keyword) => {
  kataKunci.value = keyword
  hasil.value = []

  const query = `
PREFIX aks: <http://aksarasunda.org/ontology#>
SELECT ?baris ?terjemahan ?transliterasi WHERE {
  GRAPH <http://carita> {
    ?baris a aks:Baris ;
           aks:memilikiTerjemahan ?terjemahan ;
           aks:memilikiTransliterasi ?transliterasi .
    FILTER (
      CONTAINS(LCASE(STR(?terjemahan)), LCASE("${keyword}")) ||
      CONTAINS(LCASE(STR(?transliterasi)), LCASE("${keyword}"))
    )
  }
}`

  try {
    const res = await fetch('http://localhost:3030/carita/query', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/sparql-query',
        Accept: 'application/sparql-results+json',
      },
      body: query,
    })

    const json = await res.json()
    hasil.value = json.results.bindings.map((b) => ({
      transliterasi: b.transliterasi.value,
      terjemahan: b.terjemahan.value
    }))
  } catch (err) {
    alert('Terjadi kesalahan saat mengambil data.')
    console.error(err)
  }
}
</script>
