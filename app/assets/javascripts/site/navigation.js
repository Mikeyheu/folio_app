function navInit() {

  if ($('#navigation').hasClass("horizontal")) {
    $('#navigation .container li').hover(
      function () {
        //show its submenu
        $('ul', this).slideDown(200);

      },
      function () {
        //hide its submenu
        $('ul', this).slideUp(200);
      }
    );
  }

  if ($('#navigation').hasClass("vertical")) {
    $('li.dropdown').on('click', function(e){
      if ($(this).hasClass('open')){
        $(this).removeClass('open');
        $('ul', this).slideUp(200);
      } else {
        $(this).addClass('open');
        $('ul', this).slideDown(200);
      }
    });

    $('li.dropdown a:first').on('click', function(e){
      e.preventDefault();
    });
  }
}

