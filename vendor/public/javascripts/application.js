// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var QuestionForm = {};

QuestionForm = {
  disableForm: function() {
     $('form_indicator').style.display = 'block';
  },
  enableForm: function(form) {
     $('form_indicator').style.display = 'none';
  }
}
