import { Controller } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"

Stimulus.register("filter", class extends Controller {
  static targets = ["input", "sound", "tag"]

  toggleTag(event) {
    event.currentTarget.classList.toggle("selected")
  }

  filter() {
    let search = this.inputTarget.value
    let tags = this.tagTargets.filter((tag) => (
      tag.classList.contains("selected")
    )).map((tag) => (
      tag.dataset.tag
    ))

    if (tags.length == 0 && search === "") {
      this.soundTargets.forEach((soundCard) => {
        soundCard.classList.remove("hidden")
      })
    } else {
      this.soundTargets.forEach((soundCard) => {
        if (search !== "") {
          let nameMatch = new RegExp(search.toLowerCase()).test(soundCard.dataset.name.toLowerCase())

          nameMatch ? soundCard.classList.remove("hidden") : soundCard.classList.add("hidden")
        } else {
          let soundTags = JSON.parse(soundCard.dataset.tags)

          let tagsMatch = tags.map((tag) => (new RegExp(tag))).some((rx) => (
            soundTags.some((soundTag) => (
              rx.test(soundTag)
            ))
          ))

          tagsMatch ? soundCard.classList.remove("hidden") : soundCard.classList.add("hidden")
        }
      })
    }
  }
})
