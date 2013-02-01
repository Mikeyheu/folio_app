$(document).ready(function(){

  if ($('body').hasClass('admin')) {

    // GLOBAL VARIABLES 
    dropped_on_menu = false;
    appended = false;
    snapping = true;

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

    // Draggable and Resizable elements
    elementInit();
  }

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
    height: $(window).height() - primary_nav_height - secondary_nav_height - tertiary_nav_height
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
      $('#sortable').find('li.selected .thumbnail').css({
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

  // PAGE MENU PANEL SORTING
  $('#sortable1').nestedSortable({
    appendTo: '#panes',
    disableNesting: 'no-nest',
    connectWith: ".connected",
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
    start: function(event, ui) {
     if (ui.item.attr('class') == 'folder') {
      console.log('folder');
      $('ol.sortable li').addClass('no-nest');
    }
  },
  remove: function(event, ui){
    if (ui.item.attr('class') != 'gallery') {
      console.log("removed non gallery");
      $('#sortable1').nestedSortable('cancel');
    }
  },
  stop: function(event, ui) {
    $('#page-menu ol.sortable li').removeClass('no-nest');
    $.ajax({
      type: 'POST',
      traditional: true,
      url: $('#sortable1').data('update-url'),
      data: {
        nav_items:$('#sortable1').nestedSortable('serialize'),
        gallery_items:$('#sortable2').nestedSortable('serialize')
      }
    });
  }
});

  // ARCHIVE MENU PANEL SORTING
  $('#sortable2').nestedSortable({
    appendTo: '#panes',
    connectWith: ".connected",
    disableNesting: 'no-nest',
    forcePlaceholderSize: true,
    handle: 'div',
    helper: 'clone',
    items: 'li',
    maxLevels: 1,
    distance: 5,
    opacity: .6,
    placeholder: 'placeholder',
    revert: 250,
    tabSize: 25,
    tolerance: 'pointer',
    toleranceElement: '> div',
    start: function(event, ui) {
    },
    stop: function(event, ui) {
      $('#page-menu ol.sortable li').removeClass('no-nest');
      $.ajax({
        type: 'POST',
        traditional: true,
        url: $('#sortable1').data('update-url'),
        data: {
          nav_items:$('#sortable1').nestedSortable('serialize'),
          gallery_items:$('#sortable2').nestedSortable('serialize')
        }
      });
    }
  });
  
  // FOLDER BEHAVIOR
  $('li.folder ol').hide();

  $('li.folder div:first-child').on('click',function(){   
    if ($(this).find('i:first').hasClass('open')) {
      $(this).find('i:first').removeClass('open');
      $(this).parent().find('ol').hide();
    } else {
      $(this).find('i:first').addClass('open');
      $(this).parent().find('ol').show();
    }
  });

  // LEFT MENU DRAGGING PANEL PANES
  $('#panes').layout({
    minSize: 50, 
    center__paneSelector: ".west-center", 
    south__paneSelector:  ".west-south",
    south__size:$('#panes').height()/2
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
         gallery_id: $(event.target).parent().data('gallery-id')
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

    if ($('body').hasClass('admin')) {
      resize();
      galleryInit();
      elementInit();
      uploadInit();
    }
  });
  $.pjax.defaults.timeout = false;
}

function modalInit() {
  $(document).on('click','a[data-target=#myModal]',function(e) {
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

function elementInit() {

  // Save button functionality

  $('.save-button').on('click', function(){

    var element_string = ""
    $('.element').each(function(){

      var mini_string = "";
      mini_string += $(this).attr('id');
      mini_string += ("," + $(this).position().left);
      mini_string += ("," + $(this).position().top);
      mini_string += ("," + $(this).width());
      mini_string += ("," + $(this).height());
      if ($(this).find('.image-container').length > 0) {
        console.log('image_attributes')
        mini_string += ("," + $(this).find('.image-container').position().left);
        mini_string += ("," + $(this).find('.image-container').position().top);
        mini_string += ("," + $(this).find('.image-container').width());
        mini_string += ("," + $(this).find('.image-container').height());
      } else {
        mini_string += ",nil,nil,nil,nil"
      }
      mini_string += ("," + $(this).css('z-index'));

      if (element_string!="") {
        element_string += ("&" + mini_string);
      } else {
        element_string += (mini_string);
      }
    })

    $.ajax({
      type: 'POST',
      traditional: true,
      url: $('#page_elements').data('elements-url'),
      data: {
        page_elements: element_string
      }
    });
  });

  // Element dragging and resizing

  $('.element').draggable({
    start: function(){
      disableElements();
      $(this).addClass('selected-element');
      $(this).find('.resizing-box, .resize-border').show();
    },
    containment: ".canvas",
    stack: ".element",
    drag: function(e, ui) {
      $('#x').val($(".selected-element").position().left);
      $('#y').val($(".selected-element").position().top);
    },
    stop: function(e, ui) {
      if (snapping == true) {
        var pos = $(".selected-element").position();
        var posleft = pos.left;
        var postop = pos.top;
        $(".selected-element").css({
          left: Math.round(posleft / 20) * 20,
          top: Math.round(postop / 20) * 20
        });
      }

      $('#x').val($(".selected-element").position().left);
      $('#y').val($(".selected-element").position().top);
    },
  });

  $('.element').resizable({
    stop: function(e, ui) {
      if (snapping == true) {
        var pos = $(".selected-element").position();
        var posleft = pos.left;
        var postop = pos.top;
        var offsetLeft = Math.round(posleft / 20) * 20;
        var offsetTop = Math.round(postop / 20) * 20;
        var width = $(".selected-element").width();
        var height = $(".selected-element").height();
        var offsetWidth = Math.round(width / 20) * 20;
        var offsetHeight = Math.round(height / 20) * 20;
        $(".selected-element").css({
          left: offsetLeft,
          top: offsetTop,
          width: offsetWidth,
          height: offsetHeight
        });
      }
      $('#x').val($(".selected-element").position().left);
      $('#y').val($(".selected-element").position().top);
      $('#width').val($(".selected-element").width());
      $('#height').val($(".selected-element").height());
    },
    resize: function(e, ui) {
      $('#x').val($(".selected-element").position().left);
      $('#y').val($(".selected-element").position().top);
      $('#width').val($(".selected-element").width());
      $('#height').val($(".selected-element").height());
    },
    handles: {
      n: '.n', 
      e: '.e', 
      s: '.s', 
      w: '.w', 
      ne: '.ne', 
      se: '.se', 
      nw: '.nw', 
      sw: '.sw'
    }
  });

$('.element').click(function(event){
  if($(this).hasClass("selected-element")){
    return;
  }

  // $('#tertiary-navbar').removeClass('disappear');
  resize();

  disableElements();
  zStack(this);
  $(this).addClass('selected-element');
  $(this).find('.resizing-box, .resize-border').show();

  $('#x').val($(".selected-element").position().left);
  $('#y').val($(".selected-element").position().top);
  $('#width').val($(".selected-element").width());
  $('#height').val($(".selected-element").height());
});


  // Image container dragging and resizing
  $('.image-container').draggable().resizable({
    handles: {
      n: '.inorth', 
      e: '.ie', 
      s: '.is', 
      w: '.iw', 
      ne: '.ine', 
      se: '.ise', 
      nw: '.inw', 
      sw: '.isw'
    },
    aspectRatio: true
  });

  $('.image-container').draggable('disable').resizable('disable');

  
  $('.crop-button').on('click', function(){
    var el = $(this).closest('.element');
    event.stopPropagation();
    el.find('.image-container').css({
      width: el.find('.image-container img').width(),
      height: el.find('.image-container img').height()
    });
    el.find('.image-holder').css('overflow', 'visible');
    $('.resizing-box, .element_icons').hide();
    $('.element-container').css('overflow', 'visible');
    el.find('.resize-border, .image-resize-handles').show();
    $('.element').draggable('disable');
    el.find('.image-container img').css({
      width: '100%',
      height: '100%',
      opacity: .5
    });
    $('.image-container').draggable('disable').resizable('disable');
    el.find('.image-container').draggable('enable').resizable('enable');
  });

  // Click off thumbnail to deselect
  $('.right-inner').on("click", function(event){
    var t = $(event.target)
    if (t.hasClass('canvas') || t.hasClass('grid-background')|| t.hasClass('canvas-background')|| t.hasClass('right-inner')) {
      disableElements();
      // $('#tertiary-navbar').addClass('disappear');
      resize();
    }
  });

  // KEYPRESS
  $(document).on('keydown', function(e){

    var element = $('.selected-element');

    // if statement to check if the user is currently editing a box
    if($('.selected-element').length > 0){
      // e.preventDefault();

      switch (e.which) {
        case 37:  // left arrow
        if (e.shiftKey) {
          element.css('left', parseInt(element.css('left')) - 10);
        } else {
          element.css('left', parseInt(element.css('left')) - 1);
        }
        if(parseInt(element.css('left')) < 0) {
          element.css('left', 0);
        }
        $('#x').val(parseInt($('.selected-element').css('left')));
        $('#y').val(parseInt($('.selected-element').css('top')));
        $('#width').val(parseInt($('.selected-element').css('width')));
        $('#height').val(parseInt($('.selected-element').css('height')));
        break;
        case 38:  // up arrow
        if (e.shiftKey) {
          element.css('top', parseInt(element.css('top')) - 10);
        } else {
          element.css('top', parseInt(element.css('top')) - 1);
        }
        if(parseInt(element.css('top')) < 0) {
          element.css('top', 0);
        }
        $('#x').val(parseInt($('.selected-element').css('left')));
        $('#y').val(parseInt($('.selected-element').css('top')));
        $('#width').val(parseInt($('.selected-element').css('width')));
        $('#height').val(parseInt($('.selected-element').css('height')));
        break;
        case 39:  // right arrow
        if (e.shiftKey) {
          element.css('left', parseInt(element.css('left')) + 10);
        } else {
          element.css('left', parseInt(element.css('left')) + 1);

        }
        $('#x').val(parseInt($('.selected-element').css('left')));
        $('#y').val(parseInt($('.selected-element').css('top')));
        $('#width').val(parseInt($('.selected-element').css('width')));
        $('#height').val(parseInt($('.selected-element').css('height')));
        break;
        case 40:  // down arrow
        if (e.shiftKey) {
          element.css('top', parseInt(element.css('top')) + 10);
        } else {
          element.css('top', parseInt(element.css('top')) + 1);
        }
        $('#x').val(parseInt($('.selected-element').css('left')));
        $('#y').val(parseInt($('.selected-element').css('top')));
        $('#width').val(parseInt($('.selected-element').css('width')));
        $('#height').val(parseInt($('.selected-element').css('height')));
        break;
      }
    }
  });

  $('#update').on("click", function(){
    $('.selected-element').css({
      left: parseInt($('#x').val()),
      top: parseInt($('#y').val()),
      width: $('#width').val(),
      height: $('#height').val()
    });
  });

  $('#show-grid').change(function() {
    if (!this.checked) {
      $('.grid-background').hide();
    } else {
      $('.grid-background').show();
    }
  });

  $('#snap-grid').change(function() {
    if (!this.checked) {
      snapping = false;
    } else {
      snapping = true;
    }
  });

}


function disableElements() {
  $('.element').removeClass('selected-element');
  $('.element_icons').show();
  $('.image-holder').css('overflow', 'hidden');
  $('.resizing-box, .resize-border, .image-resize-handles').hide();
  $('.right-inner').height($('.right-inner').height()-1);
  $('.right-inner').height($('.right-inner').height()+1);
  $('.image-container').each(function(){
    $(this).css({
      width: $(this).width(),
      height: $(this).height()
    });
  });
  $('.image-container img').each(function(){
    $(this).css({
      width: $(this).width(),
      height: $(this).height(),
      opacity: 1
    });
    $('.image-container').draggable('disable').resizable('disable');
    $('.element').draggable('enable').resizable('enable');
  })
}

function zStack(clicked) {
  // z-index stacking
  var zmax = 0;

  $('.element').each(function(){
    var current = parseInt($(this).css('z-index'))
    zmax = current > zmax ? current : zmax
  });

    // Set element to highest z-index
    $(clicked).css({'z-index': zmax + 1})

    // Reset all z-indexs based on 0
    var blah = $('.element')
    
    blah.sort(function(a,b){
      if (parseInt($(a).css('z-index')) < parseInt($(b).css('z-index'))) {
        return -1;
      } 
      if (parseInt($(a).css('z-index')) > parseInt($(b).css('z-index'))) {
        return 1;
      } 
      return 0;
    });

    blah.each(function(index,item){
      $(item).css({ 'z-index': index})
    })
  }




