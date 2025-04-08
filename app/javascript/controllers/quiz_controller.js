import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "submitButton"];

  connect() {
    this.toggleButton();
    console.log("Quiz controller connected");
  }

  toggleButton() {
    const anyChecked = this.checkboxTargets.some((checkbox) => checkbox.checked);
    this.submitButtonTarget.disabled = !anyChecked;
  }

  check() {
    console.log("Checkbox clicked");
    this.toggleButton();
  }
}