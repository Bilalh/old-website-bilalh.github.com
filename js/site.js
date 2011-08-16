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

function removeLinkListeners()
{
  var links = document.getElementsByTagName('a');
  for (var i = 0; i < links.length; i++)
  {
    if (links[i].classList.contains('project-download-link'))
    {
      links[i].removeEventListener('mousedown', clicky.outbound);
    }
  }
}


