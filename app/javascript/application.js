// Entry point for the build script in your package.json
import Raty from 'raty.js'; // 相対パスでraty.jsをインポート
window.raty = function(elem, opt) {
  let raty = new Raty(elem, opt);
  raty.init();
  return raty;
}

import $ from 'jquery';
window.$ = $;
window.jQuery = $;

import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"