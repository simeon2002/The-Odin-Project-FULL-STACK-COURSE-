const findTheOldest = function (people) {
  let yearsOldest = 0;
  let oldestPerson;

  for (const person of people) {
    let yearsCurrentPerson;

    if (!('yearOfDeath' in person)) {
      yearsCurrentPerson = new Date().getFullYear() - person.yearOfBirth;
    } else {
      yearsCurrentPerson = person.yearOfDeath - person.yearOfBirth;
    }
    if (yearsCurrentPerson > yearsOldest) {
      yearsOldest = yearsCurrentPerson;
      oldestPerson = person;
    }
  }
  return oldestPerson;
};

// Do not edit below this line
module.exports = findTheOldest;
