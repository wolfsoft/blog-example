$(function() {

$('.tag-list').tags({
	tagData:["boilerplate", "tags"],
	suggestions:["basic", "suggestions"],
	excludeList:["not", "these", "words"]
});

$('.textarea').summernote({
	height: 400
});

});
