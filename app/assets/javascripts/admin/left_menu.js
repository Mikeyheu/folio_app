function leftMenuInit() {

  $('#sortable1').nestedSortable({
    handle: 'div',
    items: 'li',
    toleranceElement: '> div',
    maxLevels: 2,
    connectWith: ".connected",
    helper: 'clone',
    forcePlaceholderSize: true,
    placeholder: 'placeholder',
    opacity: .6
  });

  $('#sortable2').nestedSortable({
    handle: 'div',
    items: 'li',
    toleranceElement: '> div',
    maxLevels: 2,
    connectWith: ".connected",
    helper: 'clone',
    forcePlaceholderSize: true,
    placeholder: 'placeholder',
    opacity: .6

  });

//   // PAGE MENU PANEL SORTING
//   $('#sortable1').nestedSortable({
//     appendTo: '#panes',
//     connectWith: [".connected"],
//     disableNesting: 'no-nest',
//     forcePlaceholderSize: true,
//     handle: 'div',
//     helper: 'clone',
//     items: 'li',
//     maxLevels: 2,
//     distance: 5,
//     opacity: .6,
//     placeholder: 'placeholder',
//     revert: 250,
//     tabSize: 20,
//     tolerance: 'pointer',
//     toleranceElement: '> div',
//     start: function(event, ui) {
//      if (ui.item.attr('class') == 'folder') {
//       $('ol.sortable li').addClass('no-nest');
//      } 
//   },
//   remove: function(event, ui){
//     if (ui.item.attr('class') != 'gallery') {
//       $('#sortable1').nestedSortable('cancel');
//     }
//   },
//   stop: function(event, ui) {
//     $('#page-menu ol.sortable li').removeClass('no-nest');
//     // $.ajax({
//     //   type: 'POST',
//     //   traditional: true,
//     //   url: $('#sortable1').data('update-url'),
//     //   data: {
//     //     nav_items:$('#sortable1').nestedSortable('serialize'),
//     //     gallery_items:$('#sortable2').nestedSortable('serialize')
//     //   }
//     // });
//   }
// });

//   // ARCHIVE MENU PANEL SORTING
//   $('#sortable2').nestedSortable({
//     appendTo: '#panes',
//     connectWith: [".connected"],
//     disableNesting: 'no-nest',
//     forcePlaceholderSize: true,
//     handle: 'div',
//     helper: 'clone',
//     items: 'li',
//     maxLevels: 1,
//     distance: 5,
//     opacity: .6,
//     placeholder: 'placeholder',
//     revert: 250,
//     tabSize: 20,
//     tolerance: 'pointer',
//     toleranceElement: '> div',
//     stop: function(event, ui) {
//       $('#page-menu ol.sortable li').removeClass('no-nest');
//       // $.ajax({
//       //   type: 'POST',
//       //   traditional: true,
//       //   url: $('#sortable1').data('update-url'),
//       //   data: {
//       //     nav_items:$('#sortable1').nestedSortable('serialize'),
//       //     gallery_items:$('#sortable2').nestedSortable('serialize')
//       //   }
//       // });
//     }
//   });
  
//   // FOLDER BEHAVIOR
//   $('li.folder ol').hide();

//   $('li.folder div:first-child').on('click',function(){   
//     if ($(this).find('i:first').hasClass('open')) {
//       $(this).find('i:first').removeClass('open');
//       $(this).parent().find('ol').hide();
//     } else {
//       $(this).find('i:first').addClass('open');
//       $(this).parent().find('ol').show();
//     }
//   });

//   // LEFT MENU DRAGGING PANEL PANES
//   $('#panes').layout({
//     minSize: 50, 
//     center__paneSelector: ".west-center", 
//     south__paneSelector:  ".west-south",
//     south__size:$('#panes').height()/2
//   });

//   // DRAGGIN BEHAVIOR TEST FOR THUMBS INTO LEFT MENU
//   $( ".dropzone" ).droppable({
//     hoverClass: "menu-hover",
//     tolerance: "pointer",
//     accept: '.drop_allowed',
//     over: function(event, ui) {
//     },
//     drop: function( event, ui ) {

//       dropped_on_menu = true;

//       var array = []
//       $('.selected:not(:hidden)').each(function(){
//         array.push( $(this).attr('id'))
//       });
//       var string = array.join("&");
//       console.log(string)

//       $.ajax({
//         type: 'POST',
//         traditional: true,
//         url: $('#sortable').data('move-images-url'),
//         data: {
//          images: string, 
//          gallery_id: $(event.target).parent().data('gallery-id')
//        }
//      }); 
//       // $('#sortable').sortable('cancel');
//     }
//   });
}
