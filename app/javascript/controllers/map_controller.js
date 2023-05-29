import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {

  static targets = ["pigeon"]
  static values = { accessToken: String }

  connect() {
    mapboxgl.accessToken = this.accessTokenValue;
    const map = new mapboxgl.Map({
    container: 'map',
    // Choose from Mapbox's core styles, or make your own style with Mapbox Studio
    style: 'mapbox://styles/mapbox/streets-v12',
    center: [this.pigeonTargets[0].dataset.longitude, this.pigeonTargets[0].dataset.latitude],
    zoom: 5
    });

    let bounds = new mapboxgl.LngLatBounds();

    this.pigeonTargets.forEach(pigeon => {
      const coords = [pigeon.dataset.longitude, pigeon.dataset.latitude]
      bounds.extend(coords);
      new mapboxgl.Marker()
        .setLngLat(coords)
        .addTo(map);
    });

    map.fitBounds(bounds);
  }
}
