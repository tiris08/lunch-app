// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("@nathanvda/cocoon")
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


import '@doabit/semantic-ui-sass'

$(document).on('turbolinks:load', function() {
  $('.ui.radio.checkbox').checkbox();
  $('.tabular.menu .item').tab();
  $('.ui.container.positive.center_flash.message').transition('fade', '10s');
  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  })
;
})

// if you wan't to use custom variables, you should import custom styelesheet
// import 'stylesheets/semantic-ui.scss'

// import '@doabit/semantic-ui-sass/src/scss/semantic-ui.scss'
