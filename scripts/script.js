var language; 
function getLanguage() {
	  console.log(localStorage.getItem('language'));
 (localStorage.getItem('language') == null) ? setLanguage('es') : false;
  $.ajax({ 
  url:  './scripts/' +  localStorage.getItem('language') + '.json', 
  dataType: 'json', async: false, dataType: 'json', 
  success: function (lang) { language = lang } });

}

function setLanguage(lang) {
  localStorage.setItem('language', lang);
}

$(document).ready(function(){
  getLanguage();
  console.log('./scripts/' +  localStorage.getItem('language') + '.json');
  $('#div01').text(language.date);
});