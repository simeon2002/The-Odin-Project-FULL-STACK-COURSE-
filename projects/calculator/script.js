const displayElement = document.querySelector('#input-calculation');
const containerOperationButtonsTop = document.querySelector(
  '.operators-container-top'
);
const containerOperationButtonsRight = document.querySelector(
  '.operators-container-right'
);
const containerNumberButtons = document.querySelector(
  '.number-columns-container'
);

// calculator object definition:
let calculator = {
  firstOperand: 0,
  secondOperand: 0,
  result: 0,
  operators: {
    '+': sum,
    '-': subtract,
    '*': multiply,
    '/': divide,
  },
};

//adding event listeners
containerNumberButtons.addEventListener('click', mapButtonInputToDisplay);

containerOperationButtonsTop.addEventListener('click', (e) => {
  if (e.target.id === 'undo') {
    displayElement.value = '';
    console.log('input cleared');
  } else {
    // when negation is present
    if (displayElement.value.length === 0) return;
    displayElement.value = -displayElement.value;
  }
});

function mapButtonInputToDisplay(e) {
  const targetNotButton = !(
    e.target.id.startsWith('num') || e.target.id.includes('decimal-point')
  );
  const decimalPointPresent =
    e.target.id === 'decimal-point' && displayElement.value.includes('.');
  if (targetNotButton || decimalPointPresent) return;

  displayElement.value += e.target.textContent;
}

function sum(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

function multiply(a, b) {
  return a * b;
}

function divide(a, b) {
  return a / b;
}
