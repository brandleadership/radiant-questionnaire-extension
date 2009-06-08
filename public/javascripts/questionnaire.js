var newQuestionCounter = 0;

var newQuestionCounter = 0;

document.observe('dom:loaded', function() {
  $$('.question').each( function(s){ 
    var value = $(s).down('p.content').down('select').value;
    if(value == 2 || value == 3){
      $(s).down('div').down('a').addClassName('show');
    }
  });
});
