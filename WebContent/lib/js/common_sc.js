//on off

$(document).ready(function() {

	$(".btn").mouseover(function() {
		var file = $(this).attr('src').split('/');
		var filename = file[file.length - 1];
		var path = '';
		for (i = 0; i < file.length - 1; i++) {
			path = (i == 0) ? path + file[i] : path + '/' + file[i];
		}
		$(this).attr('src', path + '/' + filename.replace('_off', '_on'));

	}).mouseout(function() {
		var file = $(this).attr('src').split('/');
		var filename = file[file.length - 1];
		var path = '';
		for (i = 0; i < file.length - 1; i++) {
			path = (i == 0) ? path + file[i] : path + '/' + file[i];
		}
		$(this).attr('src', path + '/' + filename.replace('_on', '_off'));
	});

});
