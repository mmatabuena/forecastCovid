var language;
var selRegion;
var selRegionLongName;

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

function getRegion() {
  (localStorage.getItem('selRegion') == null) ? setRegion('Galicia','Galicia') : false;
}

function setRegion(reg,regLN) {
  localStorage.setItem('selRegion', reg);
  localStorage.setItem('selRegionLongName', regLN);  
  updateTexts();
  updateImages();
}

function updateTexts(){
  $('#div01').text(language.Cabecera01);
  $('#div02').text(language.Cabecera02);
  $('#div03').text(language.Cabecera03);
  $('#div04').text(language.Pie01);
  $('#div05').text(language.Pie02);	
  $('#div06').text(language.Cabecera04 + ' <' + localStorage.getItem('selRegionLongName') + '>');
  $('#div07').text(language.Pie04);
}

function updateImages(){
  $('#Imagen_I1').prop('src','./Rmds/Espana/' + localStorage.getItem('selRegion') + '/Image_I1.png');
  $('#Imagen_I2').prop('src','./Rmds/Espana/' + localStorage.getItem('selRegion') + '/Image_I2.png');
  $('#Imagen_I3').prop('src','./Rmds/Espana/' + localStorage.getItem('selRegion') + '/Image_I3.png');
  $('#Imagen_M').prop('src','./Rmds/Espana/' + localStorage.getItem('selRegion') + '/Image_M.png');  
  $('#Imagen_R1').prop('src','./Rmds/Espana/' + localStorage.getItem('selRegion') + '/Image_R1.png');
  $('#Imagen_R2').prop('src','./Rmds/Espana/' + localStorage.getItem('selRegion') + '/Image_R2.png');
  $('#aRefImagen_I1').prop('href','./Rmds/Espana/' + localStorage.getItem('selRegion') + '/Image_I1.png');
  $('#aRefImagen_I2').prop('href','./Rmds/Espana/' + localStorage.getItem('selRegion') + '/Image_I2.png');
  $('#aRefImagen_I3').prop('href','./Rmds/Espana/' + localStorage.getItem('selRegion') + '/Image_I3.png');
  $('#aRefImagen_M').prop('href','./Rmds/Espana/' + localStorage.getItem('selRegion') + '/Image_M.png');  
  $('#aRefImagen_R1').prop('href','./Rmds/Espana/' + localStorage.getItem('selRegion') + '/Image_R1.png');
  $('#aRefImagen_R2').prop('href','./Rmds/Espana/' + localStorage.getItem('selRegion') + '/Image_R2.png');
  $('#Link_InfoExt').prop('href','./Rmds/Espana/' + localStorage.getItem('selRegion') + '/main.html');
  $('#Link_Github').prop('text',language.Pie03); 
}

$(document).ready(function(){
  getLanguage();
  getRegion();
  updateTexts();
  updateImages();
  console.log("Lang: <" + localStorage.getItem('language') + ">, Reg: <" + localStorage.getItem('selRegionLongName') + ">");
});
