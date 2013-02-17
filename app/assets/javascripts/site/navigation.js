function navInit() {

  if (clickbooq.siteConfiguration == "fixed-top" || clickbooq.siteConfiguration == "full-top") {
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

  if (clickbooq.siteConfiguration == "fixed-left" || clickbooq.siteConfiguration == "full-left") {

    $('#navigation .container li').toggle(

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

}

