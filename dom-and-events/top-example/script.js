const para1 = document.createElement('p');
const h3 = document.createElement('h3');
const container = document.createElement('div');
const h1 = document.createElement('h1');
const para2 = document.createElement('p');

para1.style.cssText = 'color:red;';
para1.textContent = "Hey I'm red!";
console.log(para1);
document.body.append(para1);

h3.style['color'] = 'blue';
h3.textContent = "I'm a blue h3!";
document.body.appendChild(h3);

container.style.cssText = 'background-color: pink; border: 2px solid black;';
h1.textContent = "I'm in a div";
para2.textContent = 'ME TOO!';
document.body.append(container);
container.append(h1, para2);
