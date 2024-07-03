// BEGIN PROGRAM
const gridContainer = document.querySelector('.grid-container');
const inputGridSize = document.querySelector('input[name="grid-size"');
const btnGridSize = document.querySelector('#btn-resize');

// at loading, generate grid with specified default value
document.addEventListener('DOMContentLoaded', generateGrid);

// when resize grid button clicked -> remove previous grid and generate with new dimensions
btnGridSize.addEventListener('click', (event) => {
  removeGrid();
  generateGrid(event);
  console.log('resizing done');
});
gridContainer.addEventListener('mouseover', changeColor);

/**
 * function will change the color of a grid element based on the color selection
 */
function changeColor(event) {
  currentElement = event.target;
  if (currentElement.classList.contains('row')) return;
  currentElement.style.backgroundColor = 'red';
}

/**
 * function calculates height of each row based.
 * @param {*} gridSize: size of grid.
 * @returns
 */
function calculateHeightRow(gridSize) {
  const height = gridContainer.offsetHeight / gridSize;
  return `${(height / gridContainer.offsetHeight) * 100}%`;
}

/**
 * function calculates width of each grid element.
 * @param {*} gridSize: size of grid
 * @returns
 */
function calculateWidthEl(gridSize) {
  const gridWidth = getComputedStyle(gridContainer).width.slice(0, -2); // note: this is the actual inside-content size aka the width of the grid.
  const elementWidth = gridWidth / gridSize;
  return `${(elementWidth / gridWidth) * 100}%`;
}

/**
 * function generates a grid of specified size.
 * @param {*} event
 */
function generateGrid(event) {
  const gridSize = Number(inputGridSize.value);

  for (let i = 0; i < gridSize; i++) {
    const row = document.createElement('div');
    row.classList.add('row');
    row.style.height = calculateHeightRow(gridSize);
    for (let i = 0; i < gridSize; i++) {
      const gridEl = document.createElement('div');
      gridEl.classList.add('el');
      gridEl.style.width = calculateWidthEl(gridSize);
      row.appendChild(gridEl);
    }
    gridContainer.appendChild(row);
  }
}

function removeGrid() {
  while (gridContainer.firstChild) {
    gridContainer.firstChild.className = '';
    gridContainer.firstChild.remove();
  }
}
