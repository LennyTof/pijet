import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="adress-autocomplete"
export default class extends Controller {
  static values = { apiKey: String, default: String}

  static targets = ["address"]

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,address",
    })
    this.geocoder.addTo(this.element);
    this.geocoder.setInput(this.defaultValue);
    this.geocoder.on("result", event => this.#setInputValue(event));
    this.geocoder.on("clear", () => this.#clearInputValue());
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"];
  }

  #clearInputValue() {
    this.addressTarget.value = "";
  }

  disconnect() {
    this.geocoder.onRemove();
  }
}
