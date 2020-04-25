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
  updateTexts();
  location.reload();
}

function updateTexts(){
  $('#div01').text(language.Cabecera01);
  $('#div02').text(language.Cabecera02);
  $('#div03').text(language.Cabecera03);	
}

$(document).ready(function(){
  var pre_Lang = language;
  getLanguage();
  updateTexts();
 if (pre_Lang == null) {location.reload();}
});
