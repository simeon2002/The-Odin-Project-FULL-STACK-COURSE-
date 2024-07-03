document.addEventListener('DOMContentLoaded', () => {
  console.log('The DOM tree has been fully parsed from the HTML and loaded.');
});

window.addEventListener('load', (e) => {
  console.log('The html page AND ALL external resources have been loaded.');
  console.log(e.target);
});

document.addEventListener('beforeunload', (e) => {
  console.log('before freeing the resources used.');
  console.log(e.target);
});

document.addEventListener('unload', (e) => {
  console.log('sent some analytical data after unloading the resources');
  console.log(e.target);
});
