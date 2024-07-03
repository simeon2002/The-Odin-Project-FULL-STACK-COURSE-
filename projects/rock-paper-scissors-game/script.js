function computerGuess() {
  return Math.floor(Math.random() * 3);
}

function changeComputerGif(computerGuess) {
  const imgComputer = document.querySelector('.computer-container img');
  console.log(imgComputer.src);
  console.log(computerGuess);
  switch (computerGuess) {
    case 0:
      imgComputer.src = 'rock.gif';
      return;
    case 1:
      imgComputer.src = 'scissors.gif';
      return;
    case 2:
      imgComputer.src = 'paper.gif';
      return;
    default:
      return;
  }
}

function getUserChoice(e) {
  return parseInt(e.currentTarget.dataset.choice); // corresponds to the equivalent choice 0 = rock, 1 = scissors, 2 = paper
}

/**
 *
 * @returns -1: computer won, 0: a tie, 1: user won
 */
function determineWinner(userGuess, pcGuess) {
  let roundWinner;
  switch (userGuess) {
    case 0:
      if (pcGuess == 0) roundWinner = 0;
      else if (pcGuess == 1) roundWinner = 1;
      else roundWinner = -1;
      break;
    case 1:
      if (pcGuess == 0) roundWinner = -1;
      else if (pcGuess == 1) roundWinner = 0;
      else roundWinner = 1;
      break;
    case 2:
      if (pcGuess == 0) roundWinner = 1;
      else if (pcGuess == 1) roundWinner = -1;
      else roundWinner = 0;
      break;
    default:
      roundWinner = 0;
      break;
  }
  console.log(roundWinner);
  return roundWinner;
}

/**
 * function updated result of user and computer. if Tie, both will get a point.
 * When 5 rounds are played, a gamewinner message will be displayed.
 */
function updateResult() {
  const resultContainer = document.querySelector('.result-container');
  const resultMessage = resultContainer.children[0];
  console.log(resultMessage);

  const userScoreEl = resultMessage.children[0];
  const computerScoreEl = resultMessage.children[1];

  if (countRoundsPlayed == 5) {
    resultMessage.textContent = `The game is over! `;
    finalResult = counterUserWon - counterComputerWon;
    if (finalResult == 0)
      resultMessage.textContent += `The game was a tie, with a result of ${counterUserWon} against ${counterComputerWon}.`;
    else if (finalResult > 0)
      resultMessage.textContent += `You have won, with a result of ${counterUserWon} against ${counterComputerWon} for you!`;
    else
      resultMessage.textContent += `Unfortunately, the computer has won, with a result of ${counterComputerWon} against ${counterUserWon}.`;
  } else {
    userScoreEl.textContent = counterUserWon;
    computerScoreEl.textContent = counterComputerWon;
  }
}

/**
 * function playing a round. 0 = rock, 1 = scissor, 2 = paper
 * @returns 1 if user has won, 0 if tie, -1 if computer has won
 */
function playRound(e) {
  const pcGuess = computerGuess();
  changeComputerGif(pcGuess);
  const userGuess = getUserChoice(e);

  let roundResult = determineWinner(userGuess, pcGuess);
  // updates result
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

  countRoundsPlayed++;
  updateResult();
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
  const btnRock = document.querySelector('#rock-btn');
  const btnPaper = document.querySelector('#paper-btn');
  const btnScissors = document.querySelector('#scissors-btn');

  btnRock.addEventListener('click', playRound);
  btnPaper.addEventListener('click', playRound);
  btnScissors.addEventListener('click', playRound);

  // displayResultMessage(counterUserWon, counterComputerWon);
  // }
  // displayWinnerMessage(counterUserWon, counterComputerWon);
}

// BEGIN PROGRAM
let counterUserWon = 0;
let counterComputerWon = 0;
let countRoundsPlayed = 0;
playGame();
