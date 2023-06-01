import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {

  static values = {
    bookedDates: Array,
    defaultDates: Array
  }

  connect() {
    flatpickr(this.element, {
      mode: "range",
      minDate: new Date().fp_incr(1), // tomorrow
      disable: this.bookedDatesValue,
      defaultDate: this.defaultDatesValue
    });
  }
}
