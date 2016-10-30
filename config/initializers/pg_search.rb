PgSearch.multisearch_options = {
  using: {
    trigram: {
      threshold: 0.5
    },
    dmetaphone: {
      any_word: true
    },
    tsearch: {
      any_word: true,
      dictionary: 'english',
      normalization: 2
    }
  },
  ignoring: :accents
}
