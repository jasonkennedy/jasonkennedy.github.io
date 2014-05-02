// = triggers
//-----------------------------------------------------------------------------//

$('.js-trigger__search').on('click', function() {
    $('.js-panel__search').toggle(); 
	$('.js-panel__nav--utility').hide(); 
});

$('.js-trigger__nav--utility').on('click', function() {
    $('.js-panel__nav--utility').toggle(); 
	$('.js-panel__search').hide(); 
});


jQuery.expr[':'].parents = function(a,i,m){
    return jQuery(a).parents(m[3]).length < 1;
};

function toggleNavSearch(container, e) {
	e.preventDefault();
	$('header').find('.toggle').filter(':parents(' + container + ')').removeClass('show');
	$(container).find('.toggle').toggleClass('show');
	$('.wrap-search, .nav-utility').each(function(index, element) {
		var link = $(element).find('.utility-link, .search-link');
        if($(element).find('.toggle').hasClass('show')) {
			link.addClass('active');
		} else {
			link.removeClass('active');
		}
    });
}


function loadAsync(url, loadFn) {
    loadFn = loadFn || function() {}
    $(function() {
	    var script = document.createElement('script');
	    script.src = url;
	    script.async = true;
	    $(script).on('load', loadFn);
	    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(script, s);
	});
}


$(function () {
    
    $('#tabs').children('li').first().children('a').addClass('active')
        .next().addClass('is-open').show();
        
    $('#tabs').on('click', 'li > a', function() {
        
      if (!$(this).hasClass('active')) {

        $('#tabs .is-open').removeClass('is-open').hide();
        $(this).next().toggleClass('is-open').toggle();
        
        $('#tabs').find('.active').removeClass('active');
        $(this).addClass('active');
      } else {
        $('#tabs .is-open').removeClass('is-open').hide();
        $(this).removeClass('active');
      }
   });
});


$(".js-toggle-content").hide();
$(".js-toggle.js-toggle-open").addClass("js-toggle-active").next().show();

var toggleNavFilter = function (elem) {
	elem.siblings('div').toggle();
	elem.children('i').toggleClass("icon-plus-squared").toggleClass("icon-minus-squared");
	elem.toggleClass("js-toggle-active");
};

var toggle = $('.js-toggle');

toggle.on('click', function () {
	toggleNavFilter($(this));
});


/* TABS ------------ */
$(document).foundationTabs(); 


/* TOOLTIPS ------------ */
$('.has-tip').addClass('tip-top');
$(this).foundationTooltips();


/* AUDIOPLAYER ------------ */
$( function() { $( 'audio' ).audioPlayer(); } );


/* FONTELLO FOE IE7 ------------ */
  function toggleCodes(on) {
	var obj = document.getElementById('icons');
	
	if (on) {
	  obj.className += ' codesOn';
	} else {
	  obj.className = obj.className.replace(' codesOn', '');
	}
  }
  
 /* FLEXLSIDER ------------ */ 
// Can also be used with $(document).ready()
$(window).load(function() {
  $('#flexslider-work').flexslider({
    animation: "slide",
	directionNav: false,  
	slideshow: false,
    controlNav: "thumbnails",
	controlsContainer: ".flex-control-nav-custom"
  });
  
  $('#flexslider-home').flexslider({
		animation: "fade",
		slideshow: false
	  });
	  
	$('#flexslider-carousel').flexslider({
		animation: "slide",
		animationLoop: false,
		controlNav: false,  
		itemWidth: 24,
		itemMargin: 1,
		minItems: 3,
		maxItems: 20,
		slideshow: false
	  });
  
});
	
	
	
/* STICKY PRIMARY NAV ------------ */ 	
$(function() {
	var div = $('#fixed');
	var start = $(div).offset().top;
 
	$(window).bind("scroll", function() {
		var p = $(window).scrollTop();
		$(div).toggleClass('fixed', p > start);
	});
 
});


	
$(function(){
  $.scrollIt();
});
