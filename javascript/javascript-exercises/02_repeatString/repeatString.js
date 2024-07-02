const repeatString = function (str, timesToRepeat) {
  if (timesToRepeat < 0) return 'ERROR';
  return str.repeat(timesToRepeat);
};

// Do not edit below this line
module.exports = repeatString;
