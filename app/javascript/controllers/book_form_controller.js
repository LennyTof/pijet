import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="book-form"
export default class extends Controller {
  static targets = [
    "startDate",
    "endDate",
    "nbOfDays",
    "rental",
    "grooming",
    "service",
    "tax",
    "total"
  ]

  static values = {
    price: Number,
    grooming: Number,
    service: Number,
    tax: Number
  }

  connect() {
  }

  update() {
    const startDate = new Date(this.startDateTarget.value);
    const endDate = new Date(this.endDateTarget.value);
    if (!isNaN(startDate) && !isNaN(endDate)) {

      const nb_of_days = (endDate - startDate) / 86400000; // divide by number of miliseconds in one day
      const rentalPrice = nb_of_days * this.priceValue;
      const groomingPrice = this.groomingValue;
      const servicePrice = nb_of_days * this.serviceValue;
      const taxPrice = Math.round(rentalPrice * this.taxValue * 100) / 100;

      this.nbOfDaysTarget.innerText = nb_of_days;
      this.rentalTarget.innerText = rentalPrice;
      this.serviceTarget.innerText = servicePrice;
      this.taxTarget.innerText = taxPrice;
      this.totalTarget.innerText = rentalPrice + groomingPrice + servicePrice + taxPrice;
    } else {
      console.log("Enter valid date.");
    }
  }
}
