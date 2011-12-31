function makeEmail()
{
  var nf323   = "terr";
  var py23432 = ".h";
  var px13452 = "lto:b";
  var dsada   = "l.com"
  var fdsff   = "a";
  var a343t   = "@gmai";
  var rdfsdf   = "mai";
  return rdfsdf+px13452+py23432+nf323+fdsff+a343t+dsada;
}                           


$(document).ready(function() {
     
    $('a#mail').prop("href", makeEmail())

});
 


window.addEvent('domready',function(){

  /* search */
  var searchBox = $('.gsc-input > input'), searchLoaded=false, 
	searchFn = function() {

      //add listeners to search box
      searchBox.addEvents({
        keyup: function(e) {
          if(searchBox.value && searchBox.value != "Search") {
            container.fade(0.9);
            control.execute(searchBox.value);
          }
          else {
            container.fade(0);
          }
        }
      });
      searchBox.removeEvent('focus',searchFn);
    }
  };
  searchBox.addEvent('focus',searchFn);
});