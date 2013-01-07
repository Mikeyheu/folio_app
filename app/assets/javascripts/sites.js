function resize() {
  var primary_nav_height = $('#primary-navbar').height();
  var secondary_nav_height = $('#secondary-navbar').height();
  var tertiary_nav_height = $('#tertiary-navbar').height();
  var left_menu_pos = $('.left-panel').position().left;
  $('.content').height($(window).height() - primary_nav_height);
  $('.right-inner').css({
    height: $(window).height() - primary_nav_height - secondary_nav_height - tertiary_nav_height - 20
  });
  $('#panes').css({
    height: $(window).height() - primary_nav_height - secondary_nav_height
  });
  $('.right-panel').css({
    left: left_menu_pos + $('.left-panel').width(),
    width: $(window).width() - $('.left-panel').width() - left_menu_pos
  });
}

jQuery(function() {

  // GLOBAL VARIABLE HERE MIKE BE CAREFUL!!!
  dropped_on_menu = false;
  appended = false;

  // WINDOW RESIZE 
  resize();

  $(window).on("resize", function(){
    resize();
  });

  // HTML5 Push State
  $(document).on("click", "a.ajax", function(e){
    e.preventDefault();
    history.pushState(null, document.title, e.target.href);
    $("body").addClass("historypushed");
  });

  $(window).bind("popstate", function() {
    if($("body").hasClass("historypushed")) { 
      $.getScript(location.href);
    }
  });

  // NEED TO ADD HISTORY FALLBACK TO REMOVE REMOTE TRUE ON LINKS

  // UPLOAD BUTTON 
  $('#new_image').fileupload({
    dataType: 'json',
    start: function(e) {
    	// $('#upload_tracker').html('Upload in progress. Please wait.');
    },
    stop: function(e) { 
      
      $.ajax({
          type: 'GET',
          traditional: true,
          url: $('#sortable').data('gallery-url')
        });   
      
    }
  });

  //  // Upload Button 
  // if($('#sortable').data('gallery_id')) {
  //   $('#hidden_field').html('<input id="gallery_id" name="gallery_id" type="hidden" value="' + $('#sortable').data('gallery_id') + '">');
  //   $('#new_image').fileupload('enable');
  // } else {
  //   $('#new_image').fileupload('disable');
  // }

    // Click upload link area and fire upload - test this!!!
  $('#input_link_area').click(function(){
    if($('#hidden_field').children().length > 0) {
      $('#image_image_file').click();
    } else {
      alert("Please select or create a gallery first");
    }
  });

    $('#image_image_file').click(function(e) {
    e.stopPropagation(); // stop event bubbling
  });

  // LEFT MENU PANEL SORTING

  $('ol.sortable').nestedSortable({
    disableNesting: 'no-nest',
    forcePlaceholderSize: true,
    handle: 'div',
    helper: 'clone',
    items: 'li',
    maxLevels: 2,
    distance: 5,
    opacity: .6,
    placeholder: 'placeholder',
    revert: 250,
    tabSize: 25,
    tolerance: 'pointer',
    toleranceElement: '> div',
    stop: function(event, ui) {

      $.ajax({
        type: 'POST',
        traditional: true,
        url: $(this).data('update-url'),
        data: {nav_items:$('ol.sortable').nestedSortable('serialize')}
      });
    }
  });

  $('li.folder ol').hide();

  $('li.folder div:first-child').toggle(function(){
    $( this ).find('i').addClass("open");
    $(this).parent().find('ol').show();
  }, function(){
    console.log("hide");
    $( this ).find('i').removeClass("open");
    $(this).parent().find('ol').hide();
  });

  // LEFT MENU DRAGGING PANEL PANES

  $('#panes').layout({
    minSize: 50, 
    center__paneSelector: ".west-center", 
    south__paneSelector:  ".west-south",
    south__size:100
  });

  // Modal behavior

  $("a[data-target=#myModal]").on('click',function(e) {
    e.preventDefault();
    var target = $(this).attr('data-target');
    var url = $(this).attr('href');
    $(target).load(url, function(){
      $("#myModal").modal("show"); 
    });
  });


  // DRAGGIN BEHAVIOR TEST FOR THUMBS INTO LEFT MENU

  $( ".dropzone" ).droppable({
    hoverClass: "menu-hover",
    tolerance: "pointer",
    accept: '.drop_allowed',
    over: function(event, ui) {
    },
    drop: function( event, ui ) {

      dropped_on_menu = true;

      var array = []
      $('.selected:not(:hidden)').each(function(){
        array.push( $(this).attr('id'))
      });
      var string = array.join("&");
      console.log(string)

      $.ajax({
        type: 'POST',
        traditional: true,
        url: $('#sortable').data('move-images-url'),
        data: {
         images: string, 
         gallery_id: $(event.target).parent().attr('id') 
        }
      }); 

      // $('#sortable').sortable('cancel');
    }
  });

});


