if (typeof console == "undefined" || typeof console.log == "undefined") var console = { log: function() {} };
function log() {    
	//var o = Array.prototype.join.call(arguments, ', ');
	//console.log( o );
    console.log( Array.prototype.slice.call(arguments) );
}
$(function($){
	var $androidLogo = $("#android_iframe");
	var $appleIFrame = $("#apple_iframe");
	var $naviRight = $("#navi-section-fixed-right");
	var androidLogoShow = false;
	var intervalID = -1;
	var mode = "desktop";
	var iFrameLoaded = false;
	var listItems = {};
	var isWidthLess1072;
	var delayShowMenu= -1;
	
	if($.browser.msie && $.browser.version < 9){
		$('#ie_go_to_hell').show(0);
		$('#icon').css('background-image', 'url(images/ieCrash.png)');
	}

	
	var SWF_URL = {
		/*12:"drawPencil_web",
		13:"microphone_web",
		14:"stagevideo_web",
		15:"p2p_web"*/
	}
	var SWF_URL_TITLE = {
/*		12:"CH13 簡單畫筆",
		13:"CH14 麥克風錄音",
		14:"CH15 高畫質影音播放器",
		15:"CH16 P2P 聊天室"*/
	}

	
	/*$.address.init(function (event) {
       // console.log('init: ' + $.address.value() + " " + $.address.path());
    }).bind('change', addressChangeHandler);
	function addressChangeHandler(){
	    var value = $.address.value();
		log("addressChangeHandler() value:"+value , $.address.parameterNames());
		scrollToPosition( parseInt(value.substr(1,value.length-1)) );
       // var index = jQuery.inArray(value, ADDRESS);
       // log('anchor change: ' + value+" index:"+index);		
       // if (index != -1) {		   
		//}
	}*/
	
	$("#android_btn").click(function(e) {
        tracker("android_btn");
		return true;
		//alert('coming soon');return false;
    });
	$("#ios_btn").click(function(e) {
        tracker("ios_btn");
		//alert('APP 近日即將上架，敬請期待..');return false;
		return true;
    });
	$("#fb_btn").click(function(e) {
        tracker("fb_btn");
    });
	

	// colorbox
	/*$(".list-item").each(function(index, element) {
      	if( SWF_URL[index] ){
			$(this).css("cursor","pointer");
		}
    }).click(function() {
		if( mode != "desktop" ){
			return false;
		}		
		var index = $(".list-item").index($(this));
		var swf = SWF_URL[index]; 
		if( swf != undefined ){
			$.colorbox({
				iframe: true,
				innerWidth: '960px',
				innerHeight: '600px',
				href: "showFlash.html?f="+swf,
				title: SWF_URL_TITLE[index]
    	    });
		}
		tracker("swf_"+swf);	    
        return false;
    });*/

	// 魂斗羅密技
	var contra = new Contra( function(){
		tracker("contra");
		$(window).unbind("keydown",onKeyDown);	
	});
	$(window).bind("keydown",onKeyDown);
	function onKeyDown(e){
		contra.onKeyDown(e.keyCode);
	}	
	
	// android
	function iLoveAndroid(){
		log("iLoveAndroid");
		setInterval( function(){
			androidLogoShow = !androidLogoShow;
			if( androidLogoShow ){		
				//$androidLogo.animate({left:-310},350);
				$androidLogo.transition({x:-310},350);
				
			}else{
//				$androidLogo.animate({left:0},500);	
				$androidLogo.transition({x:0},350);
			}
		} , 5000 );
	}	
	function iLoveApple(){
		log("iLoveApple");
		setInterval( function(){
			androidLogoShow = !androidLogoShow;
			if( androidLogoShow ){		
				//$appleIFrame.animate({left:380},350);						
				$appleIFrame.transition({x:380},350);						
			}else{
				//$appleIFrame.animate({left:0},500);		
				$appleIFrame.transition({x:0},350);						
			}
		} , 5000 );
	}	
	
	$("#goTop").click(function(e) {
		tracker("goTop");
       	$("html, body").stop().animate({ scrollTop: 0}, 1000,"easeInOutExpo",function(){
			//$("#goTop").hide();			
		});		
    });

	
	$("#navi-section-fixed-right li a").click(function(e) {      
		var index = $("#navi-section-fixed-right li").index($(this).parent());
//		$.address.value( index );
		scrollToPosition( index );
		return false;
    });
	
	function scrollToPosition( index ){
		tracker("scrollToPosition_"+index);
		$("html, body").stop().animate({ scrollTop: 680*index+700}, 1000,"easeInOutExpo",function(){
		});
		$("#selected").animate({"top":(index*22+1)+"px"},1000,"easeInOutExpo");
	}

 	setTimeout(function(){
      //  window.scrollTo(0, 1);
        $( window).resize(resize);	
		$( window).scroll(function(e) {        
			var scrollTop = $(document).scrollTop();		
			var range = scrollTop+$(window).innerHeight();
			//log( scrollTop );
			var index = 0;
			for( var a in listItems){
				var $item = listItems[a];
				if( $item.position().top< range){				
					loadImage( $item );			
					var index = $item.data("index")+"";
					listItems[index] = null;
					delete listItems[index];
				}
				index++;
			}
	    });
    	resize();
    }, 100);	
	function resize() {
        var w = $(window).width();
		if( w > 760 ){
			mode = "desktop";
		}else{
			mode = "mobile";
		}
		isWidthLess1072 = w <= 1400 ? true : false;
		//log("mode:"+mode);
		if( mode == "desktop"){
			var top = ($(window).height() - $("#navi-section-fixed-right").height() )/ 2;
			//console.log(top);
			$("#navi-section-fixed-right").css("top",top);
			
			if( !iFrameLoaded ){
				setTimeout( function(){
					var index = Math.random() > 0.5;
					if( index ){
						$("#android_iframe").attr("src","android.swf.html");
						setTimeout( iLoveAndroid , 3000 );								
					}else{
						$("#apple_iframe").attr("src","apple.swf.html");				
						setTimeout( iLoveApple , 3000 );								
					}
				} , 3500 );				
				iFrameLoaded=true;

			}
		}
    }
	setTimeout( function(){
		tracker("mode_"+mode);
	} ,5000);
	
	function loadImage( $div ){
		var imgSrc = $div.attr("lazySrc");
		log( "loadImage:" +imgSrc );
		$('<img>').attr('src', imgSrc).on('load', function() {		
		    log( "loadImageComplete:" +imgSrc );		
			$div.css('background-image', 'url(' + imgSrc+')');
			$div.fadeTo(0,0).fadeTo("slow",1);
			$div.css("lazySrc",null);
		});			
	}
	

// <!--         	<div class="list-item-image"></div> -->

	$(".list-item-image").each(function(index, element) {  
		var $this = $(this);
		listItems[index+""] = $this;
		//listItems.push( {tag:1 , target:$this} );  		
		var imgSrc = "images/"+(index+1) + '_2.png';
		$this.data("index",index)
		.attr("lazySrc", imgSrc );
		var parent = $(this).parent()
		.hover(function(){
			if( mode !=  "desktop")
				return;
			if( isWidthLess1072 ){
				$naviRight.transition(
					{x:189}
				,350,'snap');
			}
			var $txt = $(this).find(".listTXT");
			$txt.fadeIn(0);
			$txt.stop().transition({				
			    perspective: '300px',
			    rotateX: '180deg'
			},0);
			$txt.transition({				
			    perspective: '300px',
			    rotateX: '0deg'
			},350,'snap');
		},function(){
			if( mode !=  "desktop")
				return;
			$(this).find(".listTXT").fadeOut(200);
			if( isWidthLess1072 ){
				$naviRight.stop().transition(
					{x:0}
				);
			}
		});	

    });
	


});


Contra = (function(){
	var keyArr = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65];	
	function Contra( onComplete ){			
		this.index = 0;
		this.keyArrLength = keyArr.length;
		this.onComplete = onComplete;
	}
	Contra.prototype.onKeyDown = function( keyCode ){
		if ( keyCode == keyArr[this.index]) {
			if ( this.index == this.keyArrLength - 1) {
				this.onComplete();
				log("Yes");
				alert("密技!, 可以下載程式碼，但我還沒寫完, Sorry");
			}
			this.index++;
			return;		
		}			
		this.index = 0;
	}
	return Contra;
})(jQuery);

