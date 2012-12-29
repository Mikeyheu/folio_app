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
  

   // GLOBAL VARIABLE HERE MIKE BE CAREFUL!!!
  dropped_on_menu = false;
  appended = false;

  // WINDOW RESIZE 

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

  resize();

  $(window).on("resize", function(){
  resize();
  });

  // SLIDING PANEL CODE

  $('#caret').toggle(function(){
    $('.left-panel').css({ left:-220 });
    $('#caret .icon').removeClass('caret-left').addClass('caret-right');
    resize();
  }, function(){
    $('#caret .icon').removeClass('caret-right').addClass('caret-left');
    $('.left-panel').css({ left:0 });
    resize();
  });


  // LEFT MENU PANEL SORTING

  $('ol.sortable').nestedSortable({
    disableNesting: 'no-nest',
    forcePlaceholderSize: true,
    handle: 'div',
    helper: 'clone',
    items: 'li',
    maxLevels: 2,
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

  // Stop propagation of nav link if text is clicked
  $('#page-menu li div a').on("click", function(e) {
    e.preventDefault;
    e.stopPropagation();
    $('#page-menu li div').removeClass("active");
    $(this).parent().addClass("active");
  });

  // LEFT MENU DRAGGING PANEL PANES

  $('#panes').layout({
    minSize: 50, 
    center__paneSelector: ".west-center", 
    south__paneSelector:  ".west-south",
    south__size:100
  });


  // THUMBNAIL GALLERY SORTABLE CODE

  $('#sortable').multisortable({
    placeholder: "mh-placeholder",
    helper: 'clone',
    appendTo: '#content',
    scrollSensitivity:70,
    forcePlaceholderSize: true,
    tolerance: "pointer",
    
    start: function(event, ui) {
      dropped_on_menu = false;
      ui.placeholder.height(120);
      ui.placeholder.width(120);
      var foo = $('<span id="thumb-num" class="badge badge-important"></span>');
      foo.html($('.selected:not(:hidden)').length);
      foo.css ({
        position:'absolute',
        right:'10px',
        bottom:'10px'
      });
      ui.helper.find('div').css({
        opacity:.6
      });
      ui.helper.append(foo);
      //$('#sortable').find('li:hidden').show();
      //$('#sortable').find('li.selected.ui-sortable-helper').show();
    },
    stop: function(event, ui) {
      $('#sortable').find('li.selected').show();
      $('#sortable').find('li.selected div').css({
        opacity:1
      });
      $('#thumb-num').remove();
      if(dropped_on_menu == true) {
        $('#sortable').sortable('cancel');
        dropped_on_menu == false;
      }
      appended = false  

      $.ajax({
        type: 'POST',
        traditional: true,
        url: $('#sortable').data('update-url'),
        data: {
         images: $('#sortable').sortable('serialize'), 
         gallery_id: $('#sortable').data('gallery_id')
        }
      });
    }
  });

  // Click off thumbnail to deselect

  $('.content').on("click", function(event){
    if (event.target.nodeName != 'IMG') {
      $('.thumb_grid li').removeClass('selected');
    }
  });

  // Click upload link area and fire upload - test this!!!
  $('#input_link_area').click(function(){
    $('#image_image_file').click();
  });

  $('#image_image_file').click(function(e) {
    e.stopPropagation(); // stop event bubbling
  });

});


