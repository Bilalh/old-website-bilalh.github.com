$(document).ready(function() {
	$('form#search').submit(function() {
			search($('input#query').val());
		return false;
	}); 
});

function search(query) {
	var result = $.getJSON('http://dcz51.api.indextank.com/v1/indexes/BsBlog/search?q=' + encodeURIComponent(query) + '&fetch=title&snippet=text&callback=?', function(data) {
		$.each(data.results, function(index, result) {
			$('div#results').html('<div id="result">\
					<p><a href="http://bilalh.github.com/' + result.docid + '">' + result.title + '</a><br/>\
					' + result.snippet_text + '</p>\
			</div')
		});
	});
	$('#main-content').hide();
	$('#indextank').show();
}