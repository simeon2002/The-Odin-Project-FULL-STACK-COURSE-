const palindromes = function (str) {
  str = str.toLowerCase();

  if (['!', '?', '.', ','].includes(str.at(-1))) str = str.slice(0, -1);

  const strArr = str.split('');
  strArrFiltered = strArr.filter((char) => {
    if (char === ' ' || char === ',') return false;
    return true;
  });
  str = strArrFiltered.join('');
  const strReversed = strArrFiltered.reverse().join('');
  console.log(strReversed);
  console.log(str);
  return strReversed === str;
};

// Do not edit below this line
module.exports = palindromes;
