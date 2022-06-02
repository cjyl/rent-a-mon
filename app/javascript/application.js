// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import "jquery.barrating.min.js"
import "fontawesome-stars.css"

document.addEventListener("turbolinks:load", function(event) {
  $(function() {
    $('#rating-stars').barrating({
      theme: 'fontawesome-stars'
    });
  });
});
