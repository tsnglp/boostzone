import { Controller } from "@hotwired/stimulus"

const SCRIPT_SRC = "https://challenges.cloudflare.com/turnstile/v0/api.js"

// Renders a Cloudflare Turnstile widget explicitly so it survives Turbo
// navigations (implicit rendering only runs once on script load).
export default class extends Controller {
  static values = { sitekey: String }

  connect() {
    if (window.turnstile) {
      this.renderWidget()
    } else {
      this.loadScript()
    }
  }

  disconnect() {
    if (this.widgetId && window.turnstile) {
      window.turnstile.remove(this.widgetId)
      this.widgetId = undefined
    }
  }

  loadScript() {
    if (!document.querySelector(`script[src="${SCRIPT_SRC}"]`)) {
      const script = document.createElement("script")
      script.src = SCRIPT_SRC
      script.async = true
      script.defer = true
      document.head.appendChild(script)
    }
    this.waitForTurnstile()
  }

  waitForTurnstile() {
    if (window.turnstile) {
      this.renderWidget()
    } else {
      this.timeout = setTimeout(() => this.waitForTurnstile(), 100)
    }
  }

  renderWidget() {
    if (this.widgetId !== undefined) return
    this.widgetId = window.turnstile.render(this.element, {
      sitekey: this.sitekeyValue
    })
  }
}
