//= etherpad.js

$(document).ready(function() {
	$('#note-new')
	$('.note').not('#note-new').on('click', editNote);
});

// get the pad
function getPad(url, data, selector) {
	$.getJSON(url, data, function(json) {
		selector.pad(
		{
			'host':'http://localhost:9001',
			'padId':json.pad_id,
			'userName':json.author,
			'showControls':'true',
			'showChat':'true'
		});
	});
}
		
		$('#the_whole_form_tag').replaceWith(function() {
			return $('<div>' + $('input', this).val() + '</div>');
		});
		
		var noteTitle = $('.note-title', this);
		var title = noteTitle.text();
		getPad(GROUP_NAME/new, $('.note-body', this))
		$('*').not(this).click(setNote(this));

function editNote() {
	$(this).off('click');
	$('*').not(this).click(setNote(this));
}

function setNote() {
	$(this).off('blur');
	$(this).click(editBody);
}