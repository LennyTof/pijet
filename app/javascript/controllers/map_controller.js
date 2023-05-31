import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {

  static targets = ["pigeon", "mapOverlay"]
  static values = {
    accessToken: String,
    markers: Array
  }

  connect() {
    if(this.pigeonTargets.length) {
      this.drawMap();
      this.drawMarkers();
    } else {
      this.mapOverlayTarget.classList.add("d-none");
    }
  }

  drawMap() {
    mapboxgl.accessToken = this.accessTokenValue;
    this.map = new mapboxgl.Map({
      container: 'map',
      // Choose from Mapbox's core styles, or make your own style with Mapbox Studio
      style: 'mapbox://styles/mapbox/streets-v12?optimize=true',
      center: [this.pigeonTargets[0].dataset.longitude, this.pigeonTargets[0].dataset.latitude],
      zoom: 5
    });

    this.map.on('load', () => {
      this.mapOverlayTarget.classList.add("d-none");
    });
  }

  drawMarkers() {
    let bounds = new mapboxgl.LngLatBounds();

    this.pigeonTargets.forEach((pigeonTarget, index) => {
      const coords = [pigeonTarget.dataset.longitude, pigeonTarget.dataset.latitude];

      const markerElement = document.createElement("div");
      markerElement.innerHTML = this.markersValue[index];

      const mapboxMarker = new mapboxgl.Marker(markerElement)
        .setLngLat(coords)
        .addTo(this.map);
      bounds.extend(coords);
      this.registerEventListeners(pigeonTarget, mapboxMarker.getElement())
    })

    this.map.fitBounds(bounds, { padding: 50 });
  }

  registerEventListeners(pigeonTarget, markerElement) {
    let markerPath = markerElement.querySelector("path");
    pigeonTarget.addEventListener("mouseenter", () => {
      markerPath.setAttribute("fill", "#DC2626");
    });
    pigeonTarget.addEventListener("mouseleave", () => {
      markerPath.setAttribute("fill", "#3FB1CE");
    });
    markerElement.addEventListener("mouseenter", () => {
      markerPath.setAttribute("fill", "#DC2626");
    });
    markerElement.addEventListener("mouseleave", () => {
      markerPath.setAttribute("fill", "#3FB1CE");
    });
  }
}
