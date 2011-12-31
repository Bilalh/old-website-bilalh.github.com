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
 


// window.addEvent('domready',function(){
// 
//   /* search */
//   var searchBox = $('search-box'), searchLoaded=false, searchFn = function() {
// 
//     /*
//       We're lazyloading all of the search stuff.
//       After all, why create elements, add listeners, etc. if the user never gets there?
//     */
//     if(!searchLoaded) {
//       searchLoaded = true; //set searchLoaded to "true"; no more loading!
// 
//       //build elements!
//       var container = new Element('div',{ id: 'search-results' }).inject($('search-area'),'after');
//       var wrapper = new Element('div',{
//         styles: {
//           position: 'relative'
//         }
//       }).inject(container);
//       new Element('div',{ id: 'search-results-pointer' }).inject(wrapper);
//       var contentContainer = new Element('div',{ id: 'search-results-content' }).inject(wrapper);
//       var closer = new Element('a', {
//         href: 'javascript:;',
//         text: 'Close',
//         styles: {
//           position: 'absolute', //position the "Close" link
//           bottom: 35,
//           right: 20
//         },
//         events: {
//           click: function() {
//             container.fade(0);
//           }
//         }
//       }).inject(wrapper);
// 
//       //google interaction
//       var search = new google.search.WebSearch(),
//         control = new google.search.SearchControl(),
//         options = new google.search.DrawOptions();
// 
//       //set google options
//       options.setInput(searchBox);
// 
//       //set search options
//       // search.setUserDefinedClassSuffix('siteSearch');
//       // search.setLinkTarget(google.search.Search.LINK_TARGET_SELF);
// 	  search.setSiteRestriction('bilalh.github.com');
// 
// 
//       //set search controls
//       control.addSearcher(search);
//       control.draw(contentContainer,options);
//       control.setNoResultsString('No results were found.');
// 
//       //add listeners to search box
//       searchBox.addEvents({
//         keyup: function(e) {
//           if(searchBox.value && searchBox.value != searchBox.get('placeholder')) {
//             container.fade(0.9);
//             control.execute(searchBox.value);
//           }
//           else {
//             container.fade(0);
//           }
//         }
//       });
//       searchBox.removeEvent('focus',searchFn);
//     }
//   };
//   searchBox.addEvent('focus',searchFn);
// });