import { Controller } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"

Stimulus.register("sound", class extends Controller {
  static targets = ["root", "sound"]

  async play() {
    if (current_audio) {
      await this.fadeSoundOut()
      current_audio.pause()
      this.resetAudio()
    }
    document.querySelectorAll(".soundBoard-category-sounds-soundContainer-sound").forEach((e) => {
      e.classList.remove("playing")
    })
    current_audio = this.soundTarget
    current_audio.play()

    this.rootTarget.classList.add("playing")
  }

  async stop() {
    await this.fadeSoundOut()
    current_audio.pause()
    this.resetAudio()
    this.rootTarget.classList.remove("playing")
  }

  async fadeSoundOut() {
    while (current_audio.volume != 0) {
      let new_volume = current_audio.volume - 0.05 < 0 ? 0 : current_audio.volume - 0.05
      current_audio.volume = new_volume
      await sleep(50)
    }
  }

  resetAudio() {
    current_audio.currentTime = 0
    current_audio.volume = 1
    current_audio = null
  }
})
