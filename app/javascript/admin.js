import "@hotwired/turbo-rails"
import * as bootstrap from "bootstrap/dist/js/bootstrap"
(() => {
    const sidebarToggleButton = document.querySelector("#toggleSidebar");
    const mainArea = document.querySelector('main')
    sidebarToggleButton.addEventListener('click', () => {
      const sidebar = document.querySelector("#sidebarMenu");
      if(sidebar.classList.contains("sidebar-closed")){
        sidebar.classList.remove("sidebar-closed");
        mainArea.classList.remove("w-100");
      } else {
        sidebar.classList.add("sidebar-closed");
        mainArea.classList.add("w-100");
      }
    })
  })()