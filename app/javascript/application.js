// Entry point for the build script in your package.json
import $ from 'jquery';
window.$ = $;
window.jQuery = $;
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"