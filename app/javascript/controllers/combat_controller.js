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
    // } else if (fighters.length === 2) {
    //   const player1Id = fighters[0].dataset.fighterid
    //   const playter1name = fighters[0].dataset.fightername
    //   this.player1Target.value = `${player1Id} - ${playter1name}`
    //   const player2Id = fighters[1].dataset.fighterid
    //   const playter2name = fighters[1].dataset.fightername
    //   this.player2Target.value = `${player2Id} - ${playter2name}`
    }

  }

  fight (e) {
    e.preventDefault();
    const fighters = this.playerImageTargets.filter(fighter => fighter.checked === true)
    // console.log(fighters[0].dataset.fighterid)
    if (fighters.length < 2) {
      alert("You have to pickup TWO fighters to launch the fight!")
    } else {
      const player1Id = fighters[0].dataset.fighterid
      console.log(player1Id)
      const player2Id = fighters[1].dataset.fighterid
      console.log(player2Id)
      async function launchFight(player1Id, player2Id) {
        const result = await fetch(`/fighters?player1=${player1Id}&player2=${player2Id}`, { headers: { accept: "application/json" } })
        return result.json()
      }

      launchFight(player2Id, player2Id)
        .then((data) => {
          console.log(data);
        });
    }

  }

}
