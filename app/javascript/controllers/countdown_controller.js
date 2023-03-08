import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="countdown"
export default class extends Controller {
  static targets = ["countdown"];
  connect() {
    this.startTime = new Date(this.countdownTarget.dataset.startTimeValue * 1000);
    this.endtime = new Date(this.startTime.setMinutes(this.startTime.getMinutes() + 2));
    this.endtime = new Date(this.endtime.setSeconds(this.endtime.getSeconds() + 2));
    this.countdown = setInterval(this.countdown.bind(this), 1000);
  }

  countdown() {
    const now = new Date();
    const secondRemaining = (this.endtime - now) / 1000;
    if (secondRemaining <= 0) {
      this.countdownTarget.innerHTML = "Time's up!";
      clearInterval(this.countdown);
      this.redirect();
      return;
    }

    const secondPerHour = 3600;
    const secondPerMinute = 60;
    const minutes = Math.floor((secondRemaining % secondPerHour) / secondPerMinute);
    const seconds = Math.floor((secondRemaining % secondPerMinute));
    const time_remaining = seconds < 10 ? `0${minutes}:0${seconds}` : `0${minutes}:${seconds}`;
    this.countdownTarget.innerHTML = time_remaining;
  }

  redirect() {
    this.redirectPath = this.countdownTarget.dataset.redirectPathValue;
    $.ajax({
      url: window.location.origin + this.redirectPath,
      method: 'GET',
      dataType: 'json'
    })
      .done((e) => {
        window.location.href = e.redirect;
      })
  }
}
