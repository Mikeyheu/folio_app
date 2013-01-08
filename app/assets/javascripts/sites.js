$(document).ready(function(){

  // GLOBAL VARIABLES
  dropped_on_menu = false;
  appended = false;

  //PJAX INIT
  pjaxInit();

  // INITIALIZE PUSHSTATE
  //pushStateInit();

  // WINDOW BIND RESIZE AND FIRE
  windowInit();

  // INITIALIZE GALLERY
  galleryInit();

  // INITIALIZE LEFT MENU
  leftMenuInit();
  
  // INITIALIZE UPLOAD BUTTON
  uploadButtonInit();

  // INITIALIZE UPLOAD
  uploadInit();

  // Modal behavior
  modalInit();
});


//******************* FUNCTIONS BELOW *******************//

function windowInit() {
  $(window).on("resize", function(){
    resize();
  });
  resize();
}

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

function galleryInit() {
  // THUMBNAIL GALLERY SORTABLE CODE

  $('#sortable').multisortable({
    placeholder: "mh-placeholder",
    helper: 'clone',
    appendTo: '#content',
    scrollSensitivity:70,
    forcePlaceholderSize: true,
    tolerance: "pointer",
    distance: 5,
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
      if(dropped_on_menu == false) {
        console.log('sort-images')
        $.ajax({
          type: 'POST',
          traditional: true,
          url: $('#sortable').data('update-url'),
          data: {
           images: $('#sortable').sortable('serialize'), 
           gallery_id: $('#sortable').data('gallery_id')
          }
        });       
      } else {
        $('#sortable').sortable('cancel');
        dropped_on_menu == false;
      }
      appended = false  
    }
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

  // Click off thumbnail to deselect

  $('.content').on("click", function(event){
    if (event.target.nodeName != 'IMG') {
      $('.thumb_grid li').removeClass('selected');
    }
  });
}


function leftMenuInit() {

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
  
  // FOLDER BEHAVIOR
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
}

function uploadButtonInit() {
  // FILE UPLOAD BUTTON INIT 
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

  // CLICK UPLOAD LINK AREA TO FIRE UPLOAD OR ALERT ERROR
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
}

function uploadInit() {
   // Upload Button 
  if($('#sortable').data('gallery_id')) {
    $('#hidden_field').html('<input id="gallery_id" name="gallery_id" type="hidden" value="' + $('#sortable').data('gallery_id') + '">');
    $('#new_image').fileupload('enable');
  } else {
    $('#new_image').fileupload('disable');
    $('#hidden_field').empty();
    
  }
}

function pjaxInit() {
  $(document).pjax('a.ajax', '#pjax-container');
  $(document).on('pjax:complete', function() {
    resize();
    galleryInit();
    uploadInit();
  });

  $(document).on('pjax:beforeSend', function() {
    console.log('pjax fired this');
    return false;
  });
  $.pjax.defaults.timeout = false;
}

function modalInit() {
  $("a[data-target=#myModal]").on('click',function(e) {
    e.preventDefault();
    var target = $(this).attr('data-target');
    var url = $(this).attr('href');
    $(target).load(url, function(){
      $("#myModal").modal("show"); 
    });
  });
}

function pushStateInit() {

  // HTML5 PUSH STATE (NEED TO ADD FALLBACK)
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
}







