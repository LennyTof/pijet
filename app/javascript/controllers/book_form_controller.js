import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="book-form"
export default class extends Controller {
  static targets = [
    "startDate",
    "endDate",
    "dates",
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
    this.parseDates(this.datesTarget.value);

    if (!isNaN(this.startDate) && !isNaN(this.endDate)) {
      const nb_of_days = ((this.endDate - this.startDate) / 86400000) + 1; // divide by number of miliseconds in one day
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

  parseDates(dates) {
    const datesArray = dates.split("to").map(str => str.trim());
    if(datesArray.length === 2) {
      this.startDate = new Date(datesArray[0]);
      this.endDate = new Date(datesArray[1]);
    } else {
      this.startDate = new Date(datesArray[0]);
      this.endDate = this.startDate;
    }
  }
}
