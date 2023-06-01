import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-form"
export default class extends Controller {
  connect() {
  }

  send(event) {
    event.preventDefault();

    const formData = new FormData(this.element);
    const data = Object.fromEntries(formData.entries());
    this.parseDates(data.dates);
    data.start_date = this.startDate;
    data.end_date = this.endDate;
    delete data.dates;

    const url = `${this.element.action}?${this.generateQuerystring(data)}`

    Turbo.visit(url);
  }

  parseDates(dates) {
    const datesArray = dates.split("to").map(str => str.trim());
    if(datesArray.length === 2) {
      this.startDate = datesArray[0];
      this.endDate = datesArray[1];
    } else {
      this.startDate = datesArray[0];
      this.endDate = this.startDate;
    }
  }

  generateQuerystring(params) {
    return Object.keys(params).map(key => key + '=' + params[key]).join('&');
  }
}
