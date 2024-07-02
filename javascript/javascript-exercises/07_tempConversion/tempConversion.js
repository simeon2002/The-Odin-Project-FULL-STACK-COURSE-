const convertToCelsius = function (temperature) {
  tempInCelcius = ((temperature - 32) * 5) / 9;
  return Number(tempInCelcius.toFixed(1));
};

const convertToFahrenheit = function (temperature) {
  tempInFahrenheit = (9 / 5) * temperature + 32;
  return Number(tempInFahrenheit.toFixed(1));
};

// Do not edit below this line
module.exports = {
  convertToCelsius,
  convertToFahrenheit,
};
