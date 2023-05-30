import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="range"
export default class extends Controller {
  static targets = ['rangeElement', 'input']

  connect() {
    this.#displayValue()
  }
  range(event) {
    this.#displayValue()
  }

  #displayValue(){
    this.rangeElementTarget.innerText = `${this.inputTarget.value}`;
  }
}
