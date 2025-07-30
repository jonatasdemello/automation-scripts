// Select all linked in messages

timer = setInterval(() => {

    // works as of Nov 9, 2023
    // select all messages
    items = document.querySelectorAll('.msg-selectable-entity__checkbox-circle-container');
    for (let i = 0; i < items.length; i++) {
        items[i].click();
    }
    // click Archive button
    button = document.getElementById('ember356');
    button.click();
}, 5000);

// -------------------------------------------------------------------------------------------------------------------------------
If you don't want to delete but archive or download the messages instead, you may wanna use this adapted version. It marks all messages on the page, then you can manually archive / download them and then it asks you if you want to continue with the next batch or cancel instead.(Disclaimer: I've only tested it on google chrome.)

let iteration = 0;
let delayBetweenIterations = 5000; // 5000 milliseconds (5 seconds)

function performIteration() {
  // Select all messages
  items = document.querySelectorAll('.msg-selectable-entity__entity');
  for (let i = 0; i < items.length; i++) {
    items[i].click();
  }

  iteration++;

  // Check if it's the first iteration or if the user wants to continue
  if (iteration === 1 || confirm("Do you want to continue?")) {
    setTimeout(performIteration, delayBetweenIterations);
  } else {
    clearInterval(timer); // Stop the timer if the user chooses not to continue
  }
}

performIteration()

//-------------------------------------------------------------------------------------------------------------------------------

Here a currently working script:

timer = setInterval(() => {
  // select all messages
  items = document.querySelectorAll('div.msg-selectable-entity__checkbox-container > input');
  for (let i = 0; i < items.length; i++) {
    items[i].click();
  }
  setTimeout(() => {
    // click archive button
    buttons = document.querySelectorAll('div.display-flex.mvA > button[title="Archive"]');
    if (buttons.length == 1) {
      buttons[0].click();
    }
  }, 1000);
}, 5000)