var newQuestionCounter = 0;

document.observe('dom:loaded', function() {
  $$('.question').each( function(s){
    var value = $(s).down('p.content').down('select').value;
    if(value == 2 || value == 3){
      $(s).childNodes.item($(s).childNodes.length-2).childNodes.item($(s).childNodes.item($(s).childNodes.length-2).childNodes.length-2).addClassName('show');
    }
  });
});

function markForDestroyAnswer(element) {
  $(element).next('.should-destroy').value = 1;
  $(element).up('p.content').hide();
}

function markForDestroyQuestion(element) {
  $(element).next('.should-destroy').value = 1;
  $(element).up('div.question').hide();
}

function removeCheck(subject) {
  return confirm('Do you want really remove this '+subject+'?');
}
