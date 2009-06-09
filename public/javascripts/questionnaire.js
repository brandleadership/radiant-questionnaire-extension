var newQuestionCounter = 0;

document.observe('dom:loaded', function() {
  $$('.question').each( function(s){ 
    var value = $(s).down('p.content').down('select').value;
    if(value == 2 || value == 3){
      $(s).childElements().last().childElements().last().addClassName('show');
    }
  });
});
