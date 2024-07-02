const add = function (a, b) {
  return a + b;
};

const subtract = function (a, b) {
  return a - b;
};

const sum = function (operands) {
  let sum = 0;
  for (let i = 0; i < operands.length; i++) {
    sum += Number(operands[i]);
  }

  return sum;
};

const multiply = function (operands) {
  if (operands.length === 0) return 0;
  let result = 1;
  for (const operand of operands) {
    result *= operand;
  }
  return result;
};

const power = function (base, exponent) {
  if (base === 0 && exponent !== 0) return 0;

  // if base != 0 and exponent == 0 is also included here.
  let result = 1;
  for (let i = 0; i < exponent; i++) {
    result *= base;
  }

  return result;
};

const factorial = function (operand) {
  // case operand = 0;
  if (operand === 0) return 1;

  // case operand != 0;
  let result = 1;
  for (let i = 1; i <= operand; i++) {
    result *= i;
  }

  return result;
};

// Do not edit below this line
module.exports = {
  add,
  subtract,
  sum,
  multiply,
  power,
  factorial,
};
