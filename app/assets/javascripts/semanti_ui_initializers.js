document.addEventListener('turbolinks:load', function() {
  $('select.dropdown').dropdown(({ fullTextSearch: 'exact' }));
});
