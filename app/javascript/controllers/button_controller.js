import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  hide(event) {
    this.element.classList.add("d-none")
  }

}
