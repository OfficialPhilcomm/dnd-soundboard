import { Controller } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"

Stimulus.register("tags", class extends Controller {
  static targets = ["input", "sound"]

  filter() {
    let tags = this.inputTarget.value.split(" ").filter((tag) => (
      tag !== ""
    )).map((tag) => (
      new RegExp(tag)
    ))

    if (tags.length > 0) {
      this.soundTargets.forEach((soundCard) => {
        let soundTags = JSON.parse(soundCard.dataset.tags)

        let isMatch = tags.some((rx) => (
          soundTags.some((soundTag) => (
            rx.test(soundTag)
          ))
        ))

        if (isMatch) {
          soundCard.classList.remove("hidden")
        } else {
          soundCard.classList.add("hidden")
        }
      })
    } else {
      this.soundTargets.forEach((soundCard) => {
        soundCard.classList.remove("hidden")
      })
    }
  }
})
