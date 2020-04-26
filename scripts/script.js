var language;
var selRegion;
function getLanguage() {
 // console.log(localStorage.getItem('language'));
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

function getRegion(reg) {
  (localStorage.getItem('selRegion') == null) ? setRegion('Galicia') : false;
}

function setRegion(reg) {
  localStorage.setItem('selRegion', reg);
  updateTexts();  
  //location.reload();
}

function updateTexts(){
  $('#div01').text(language.Cabecera01);
  $('#div02').text(language.Cabecera02);
  $('#div03').text(language.Cabecera03);
  $('#div04').text(language.Pie01);
  $('#div05').text(language.Pie02);	
  $('#div06').text(language.Cabecera04 + '<' + selRegion + '>');
}

$(document).ready(function(){
  getLanguage();
  getRegion();
  updateTexts();
});
