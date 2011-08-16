
$(document).ready(function() {
	$('form#search').submit(function() {
			search($('input#query').val());
		return false;
	}); 
	
	// Add the value of "Search..." to the input field and a class of .empty
	$("#query").val("Search Posts...").addClass("empty");

	// When you click on #search
	$("#query").focus(function(){

		// If the value is equal to "Search..."
		if($(this).val() == "Search Posts...") {
			// remove all the text and the class of .empty
			$(this).val("").removeClass("empty");;
		}

	});

	// When the focus on #search is lost
	$("#query").blur(function(){

		// If the input field is empty
		if($(this).val() == "") {
			// Add the text "Search..." and a class of .empty
			$(this).val("Search Posts...").addClass("empty");
		}

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