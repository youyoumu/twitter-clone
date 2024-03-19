import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["unlikeButton", "likeButton"]

    like() {
        this.unlikeButtonTarget.hidden = false
        this.likeButtonTarget.hidden = true
    }

    unlike() {
        this.unlikeButtonTarget.hidden = true
        this.likeButtonTarget.hidden = false
    }
}