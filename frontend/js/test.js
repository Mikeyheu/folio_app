$(document).ready(function(){
	function resize() {
    $("#panel").height(
    $('#container').height() - $('#controls').height() - 10);
}

$(window).on("resize", function () {
    resize();
});

resize();

$("#horizontal_alignment").on("change", function () {
    if ($(this).val() == "left") {
        if ($(".outer").hasClass("center")) {
            $("#box").css({
                left: $('#box').position().left + $('#panel').width() / 2,
                right: ""
            });
            $(".outer").removeClass('center');
        }
        $("#box").css({
            left: $("#box").position().left,
            right: ""
        });
        $('#x').val($("#box").position().left);

    } else if ($(this).val() == "right") {
        if ($(".outer").hasClass("center")) {
            $("#box").css({
                right: Math.round($("#panel").width() / 2) - ($("#box").position().left + $("#box").width()),
                left: ""
            });
            $(".outer").removeClass('center');


        } else {
            $("#box").css({
                right: $('#panel').width() - ($("#box").position().left + $("#box").width()),
                left: ""
            });
        }
        $('#x').val($('#panel').width() - ($("#box").position().left + $("#box").width()));

    } else if ($(this).val() == "center") {
        // add center class


        if ($("#box").css('right')) {
            console.log(parseInt($('#box').css('right')))
            $("#box").css({
                left: $('#panel').width() - parseInt($('#box').css('right')) - $("#box").width(),
                right: ""
            });
        }

        $("#box").css({
            left: $('#box').position().left - $('#panel').width() / 2
        });

        $(".outer").addClass('center');
    }
});

$("#vertical_alignment").on("change", function () {
    if ($(this).val() == "top") {
        $("#box").css({
            top: $("#box").position().top,
            bottom: ""
        });
    } else if ($(this).val() == "bottom") {

        $("#box").css({
            bottom: $('#panel').height() - ($("#box").position().top + $("#box").height()),
            top: ""
        });
    }
});


$('#box').draggable({

    stop: function () {
        if ($('#vertical_alignment').val() == "bottom") {
            $("#box").css({
                bottom: $('#panel').height() - ($("#box").position().top + $("#box").height()),
                top: ""
            });
        }

        if ($('#horizontal_alignment').val() == "right") {
            $("#box").css({
                right: $('#panel').width() - ($("#box").position().left + $("#box").width()),
                left: ""
            });
        }
    }

});

});