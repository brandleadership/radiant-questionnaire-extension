var newQuestionCounter = 0;

document.observe('dom:loaded', function() {
  $$('.question').each( function(s){
    var value = $(s).down('.data select').getValue();
    if(value == 2 || value == 3){
       $(s).down('div.answers').down('a').addClassName('show');
    }
  });

  Event.addBehavior( {
    '.button:click':  function() {
      $$('.checkbox_checker').each( function(element) {
          if ($(element).checked)
            $(element).next().remove();
          else
            $(element).remove();
        }
      )
    },
   'a.move-up:click':  function(event) {
        moveUp(this);
        event.stop();
    },
   'a.move-down:click':  function(event) {
        moveDown(this);
        event.stop();
    }
  });
});

function moveUp(element) {
  var questionElement = $(element).up('div.question');
  var preQuestionElement = questionElement.previous('div.question');
  var orderElement = questionElement.down('input.order-input');
  var preOrderElement =  preQuestionElement.down('input.order-input');

  changeOrderNumber(orderElement, preOrderElement);

  moveElments('up', questionElement , preQuestionElement);
}

function moveDown(element) {
  var questionElement = $(element).up('div.question');
  var postQuestionElement = questionElement.next('div.question');
  var orderElement = questionElement.down('input.order-input');
  var preOrderElement =  postQuestionElement.down('input.order-input');

  changeOrderNumber(orderElement, preOrderElement);

  moveElments('down', questionElement , postQuestionElement);
}

function changeOrderNumber(currentElement, newOrderElement){
  var orderValueSave = currentElement.readAttribute('value');
  currentElement.writeAttribute('value', newOrderElement.readAttribute('value'));
  newOrderElement.writeAttribute('value', orderValueSave);
}

function moveElments(direction, targRow, sibling) {
    var targetParent = targRow.up('div');
    if(direction == 'up'){
      targRow.remove();
      targetParent.insertBefore(targRow, sibling);
    }
    if(direction == 'down'){
      sibling.remove();
      targetParent.insertBefore(sibling, targRow);
    }
}

function markForDestroyAnswer(element) {
  $(element).next('.should-destroy').writeAttribute('value', 1);
  $(element).up('div.answer').hide();
}

function markForDestroyQuestion(element) {
  $(element).next('.should-destroy').writeAttribute('value', 1);
  $(element).up('div.question').hide();
}

function removeCheck(subject) {
  return confirm('Do you want really remove this '+subject+'?');
}