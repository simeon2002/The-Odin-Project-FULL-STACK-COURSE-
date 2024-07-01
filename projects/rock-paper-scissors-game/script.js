function computerGuess() {
  return Math.floor(Math.random() * 3);
}

function userGuess() {
  choice = Number(
    prompt(
      'What is your choice? Input 0 for rock, 1 for scissors and 2 for paper!'
    )
  );
  while (![0, 1, 2].includes(choice)) {
    choice = Number(
      prompt(
        'Incorrect choice, choose again! Input 0 for rock, 1 for scissors and 2 for paper.'
      )
    );
  }
  return choice;
}

/**
 * function playing a round. 0 = rock, 1 = scissor, 2 = paper
 * @returns 1 if user has won, 0 if tie, -1 if computer has won
 */
function playRound() {
  pcGuess = computerGuess();
  uGuess = userGuess();
  switch (uGuess) {
    case 0:
      if (pcGuess == 0) return 0;
      else if (pcGuess == 1) return 1;
      else return -1;
    case 1:
      if (pcGuess == 0) return -1;
      else if (pcGuess == 1) return 0;
      else return 1;
    case 2:
      if (pcGuess == 0) return 1;
      else if (pcGuess == 1) return -1;
      else return 0;
    default:
      break;
  }
}

function displayWinnerMessage(numberOfWinsUser, numberOfWinsComputer) {
  if (numberOfWinsUser == numberOfWinsComputer) {
    // a tie
    console.log('The game was a tie!');
  } else if (numberOfWinsUser > numberOfWinsComputer) {
    console.log('User has won the game!');
  } else {
    console.log('Computer has won');
  }
}

function displayResultMessage(numberOfWinsUser, numberOfWinsComputer) {
  result = { Computer: numberOfWinsComputer, User: numberOfWinsUser };
  console.table(result);
}

function playGame() {
  /*
  variables:
  - computerGuess
  - userGuess
  - countUserWon
  - numberOfGames
  */
  numberOfGames = Number(prompt('how many rounds to play?')) || 3;
  console.log(numberOfGames);
  counterUserWon = 0;
  counterComputerWon = 0;
  for (i = 0; i < numberOfGames; i++) {
    roundResult = playRound();
    if (roundResult == 1) {
      counterUserWon++;
      console.log('You have won this round');
    } else if (roundResult == -1) {
      counterComputerWon++;
      console.log('Computer has won this round');
    } else {
      counterComputerWon++;
      counterUserWon++;
      console.log('It was a tie');
    }
    displayResultMessage(counterUserWon, counterComputerWon);
  }
  displayWinnerMessage(counterUserWon, counterComputerWon);
}

//SET computerGuess CALL computerGuess returning guess of computer
//SET userGuess to CALL userGuess returning guess of user.
//SET numberOfGames to prompted value.
//FOR each round
//  CALL playRound() returning 1 if user 1, 0 if PC won, -1 if a tie is present.
//  IF user won
//    Increment countUserWon
//  OUTPUT display intermediate result
//ENDFOR
//IF number of user games won > computer games won
//  OUTPUT message user has won.
//ELSE
//  OUTPUT message computer has won.
//OUTPUT display details of score

// BEGIN PROGRAM
// CALL playGame
playGame();
playAgain = confirm('Want to play another game?');
while (playAgain) {
  playGame();
  playAgain = confirm('Want to play another game?');
}
console.log('The program has finished.');
