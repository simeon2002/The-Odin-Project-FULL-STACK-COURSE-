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
  operator: {
    value: '',
    operandClicked: false,
  },
  result: 0,
  operators: {
    '+': sum,
    '-': subtract,
    '*': multiply,
    '/': divide,
  },
  showSecondOperand: false, // used for input clearance for second operator
  secondOperatorMode: false, // tells button operator buttons that 2nd operand is being filled.
  firstCalculation: true, // indicated that current calculation is the first in the sequence
};

//adding event listeners
containerNumberButtons.addEventListener('click', displayFirstOperand);
containerNumberButtons.addEventListener('click', displaySecondOperand);

// listener for events undo number and negate button to negate value
containerOperationButtonsTop.addEventListener('click', (e) => {
  if (e.target.id === 'undo') {
    clearInput();
    resetCalculator();
  }
});
containerOperationButtonsTop.addEventListener('click', negateValue);

// listener on operators
containerOperationButtonsRight.addEventListener(
  'click',
  arithmeticOperatorClicked
);
containerOperationButtonsRight.addEventListener('click', (e) => {
  if (e.target.textContent === '=') {
    if (calculator.secondOperatorMode && !calculator.showSecondOperand) {
      calculator.secondOperand = getInputValue(e);
      clearInput('secondOperator');
      calculateResult();
      showResult();
      calculator.firstOperand = calculator.result;
      calculator.secondOperand = 0;
      calculator.secondOperatorMode = false;
      calculator.operator.value = '';
      calculator.operator.operandClicked = false;
      resetBgColor();
      calculator.firstCalculation = false;
    }

    calculator.showSecondOperand = false;
  }
});

//FUNCTIONS

function arithmeticOperatorClicked(e) {
  if (e.target.textContent === '=') return;
  if (!e.target.id.includes('btn') && calculator.secondOperatorMode) return;
  // revert bg color operator clicked
  resetBgColor();
  // store operator in object
  calculator.operator.value = e.target.textContent;
  // set boolean flag to true.
  calculator.operator.operandClicked = true;
  // change bg color operator clicked
  setOperatorBG(e);
  // set flag for when second operands is started to be written down.
  if (calculator.secondOperatorMode === false) {
    calculator.firstOperand = getInputValue(e);
    calculator.showSecondOperand = true;
  }
  calculator.secondOperatorMode = true;
}

function displayFirstOperand(e) {
  if (calculator.operator.operandClicked === false) {
    if (!calculator.secondOperatorMode && !calculator.firstCalculation) {
      calculator.firstCalculation = true;
      clearInput();
      calculator.firstOperand = 0;
    }
    mapButtonInputToDisplay(e);
  }
}

function displaySecondOperand(e) {
  if (calculator.operator.operandClicked) {
    if (calculator.showSecondOperand) {
      clearInput();
      calculator.showSecondOperand = false;
    }
    mapButtonInputToDisplay(e);
  }
}

function mapButtonInputToDisplay(e) {
  const targetNotButton = !(
    e.target.id.startsWith('num') || e.target.id.includes('decimal-point')
  );
  const decimalPointPresent =
    e.target.id === 'decimal-point' && displayElement.value.includes('.');
  if (targetNotButton || decimalPointPresent) return;

  displayElement.value += e.target.textContent;
}

function getInputValue(e) {
  return Number(displayElement.value);
}

function setOperatorBG(e) {
  e.target.classList.add('btn-clicked');
}

function resetBgColor() {
  const operatorButtonList = Array.from(
    containerOperationButtonsRight.children
  );
  operatorButtonList.forEach((element) => {
    btnClasses = [...element.classList];
    if (btnClasses.includes('btn-clicked')) {
      element.classList.remove('btn-clicked');
    }
  });
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

function negateValue(e) {
  if (e.target.id === 'negate') {
    if (displayElement.value.length === 0) return;
    displayElement.value = -displayElement.value;
  }
}

function calculateResult() {
  calculator.result = calculator.operators[calculator.operator.value](
    calculator.firstOperand,
    calculator.secondOperand
  );
}

function showResult() {
  displayElement.value = calculator.result;
}

function clearInput() {
  displayElement.value = '';
  console.log('input cleared');
}

function resetCalculator() {
  calculator.firstOperand = 0;
  calculator.secondOperand = 0;
  calculator.result = 0;
  calculator.operator.operandClicked = false;
  calculator.operator.value = '';
  calculator.showSecondOperand = false;
  calculator.secondOperatorMode = false;
  resetBgColor();
}
