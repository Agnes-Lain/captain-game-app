import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["playerImage", 'player1', 'player2']

  // connect() {
  //   console.log ()
  // }

  select (e) {
    e.preventDefault();
    // console.log("click")
    const fighters = this.playerImageTargets.filter(fighter => fighter.checked === true)
    if (fighters.length > 2) {
      alert("You can only choose two fighters maximum for each combat!")
      fighters[2].checked = false;
    } else if (fighters.length === 2) {
      const player1Id = fighters[0].dataset.fighterid
      const playter1name = fighters[0].dataset.fightername
      this.player1Target.value = `${player1Id} - ${playter1name}`
      const player2Id = fighters[1].dataset.fighterid
      const playter2name = fighters[1].dataset.fightername
      this.player2Target.value = `${player2Id} - ${playter2name}`
    }

  }

  // fight (e) {

  // }

}
