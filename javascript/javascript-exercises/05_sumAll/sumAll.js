const sumAll = function (a, b) {
  if (a < 0 || b < 0 || typeof a !== 'number' || typeof b !== 'number')
    return 'ERROR';

  if (b < a) {
    // if second number is bigger, we switch them around.
    c = a;
    a = b;
    b = c;
  }

  let sum = 0;
  for (let i = a; i <= b; i++) {
    sum += i;
  }

  return sum;
};

// Do not edit below this line
module.exports = sumAll;
