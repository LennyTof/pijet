import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price"
export default class extends Controller {
  static targets = ['priceElement', 'input']

  connect() {
    this.#displayValue()
  }
  price(event) {
    this.#displayValue()
  }

  #displayValue(){
    this.priceElementTarget.innerText = `${this.inputTarget.value}`;
  }
}
