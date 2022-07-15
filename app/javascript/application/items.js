$(() => {
  let currentURL = window.location.pathname
  const getjson = '.json?q='
  let options = {
    getValue: 'name',
    adjustWidth: false,
    url: function(phrase) {
      return currentURL + getjson + phrase
    }
  }
  $("[data-behavior='autocomplete']").easyAutocomplete(options)
  
  $('.ui.three.column.grid').on('cocoon:after-insert', function() {
    $("[data-behavior='autocomplete']").easyAutocomplete(options)
  })
})
