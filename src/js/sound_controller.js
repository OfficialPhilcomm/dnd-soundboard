import { Controller } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js";

Stimulus.register(
  "sound",
  class extends Controller {
    static targets = ["root", "sound"];

    handlePlay() {
      this.rootTarget.classList.add("playing");
    }

    handlePause() {
      this.rootTarget.classList.remove("playing");
    }

    async togglePlay() {
      if (this.rootTarget.classList.contains("playing")) {
        await this.stop();
      } else {
        await this.play();
      }
    }

    async play() {
      if (current_audio) {
        await this.fadeSoundOut();
        current_audio.pause();
        this.resetAudio();
      }

      current_audio = this.soundTarget;
      current_audio.play();
    }

    async stop() {
      console.log("stopping audio");
      await this.fadeSoundOut();
      current_audio.pause();
      this.resetAudio();
    }

    async fadeSoundOut() {
      while (current_audio.volume != 0) {
        let new_volume =
          current_audio.volume - 0.05 < 0 ? 0 : current_audio.volume - 0.05;
        current_audio.volume = new_volume;
        await sleep(50);
      }
    }

    resetAudio() {
      current_audio.currentTime = 0;
      current_audio.volume = 1;
      current_audio = null;
    }
  }
);
