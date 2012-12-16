jQuery(function() {
  $('#new_image').fileupload({
    dataType: 'json',
    start: function(e) {
    	$('#upload_tracker').html('Upload in progress. Please wait.');
    },
    stop: function(e) { 
    	location.reload();
    }
  });
  
  $('#sortable').sortable({
    update: function(e){

      $.ajax({
        type: 'POST',
        traditional: true,
        url: $(this).data('update-url'),
        data: {
        	images: $(this).sortable('serialize'), 
        	gallery_id: $(this).data('gallery_id')
        }
      });
    }
  });
});


