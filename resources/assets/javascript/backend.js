$(function() {

var autocompleter = new Bloodhound({
	queryTokenizer: Bloodhound.tokenizers.whitespace,
	datumTokenizer: Bloodhound.tokenizers.whitespace,
	remote: '/admin/categories.json'
});

$('.tag-list').tokenfield({
	typeahead: [null, {
		source: autocompleter.ttAdapter()
	}],
	showAutocompleteOnFocus: true
});

$('.textarea').summernote({
	height: 400
});

$('form').submit(function() {
	var self = $(this);
	self.find('div.textarea').each(function() {
		self.find("input[name='" + $(this).data('fill') + "']").val($(this).summernote('code'));
	});
	return true;
});

});
