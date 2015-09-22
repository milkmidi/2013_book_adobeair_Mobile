package com.milkmidi.stagevideo {		
	import com.milkmidi.stagevideo.media.SimpleStageVideo;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Mouse;
	import milkmidi.display.MSprite;
	import milkmidi.utils.DeviceUtil;

	[SWF(width = "800", height = "480", frameRate = "30", backgroundColor = "#000000")]		
	public class MainEntry extends MSprite {		
		
		private var _player			:SimpleStageVideo;
		private var _controllBar	:ControllBarMC;
		private var _bg				:Bitmap;
		public function MainEntry()  {			
			
			
		}
		override protected function atAddedToStage():void {
			super.atAddedToStage();
			stage.align = 'tl';
			stage.scaleMode = 'noScale';		
			
			//stage.setChildIndex
			
			try {
				stage["setAspectRatio"]( "landscape" );				
			}catch (err:Error) {
				trace( err );			
			}
		
			_player = new SimpleStageVideo( "h264Video.mp4" );			
			addChild(_player);			
		
			
			_controllBar = new ControllBarMC(_player);			
			addChild( _controllBar );		
			
			_bg = new Bitmap();
			_bg.bitmapData = new BitmapData(1, 1, false, 0);
			addChildAt( _bg , 0 );
		}
	
	
		override protected function atResize():void {
			super.atResize();
			_player.setSize( stage.stageWidth , stage.stageHeight - DeviceUtil.actionBarHeight );													
			_bg.width = stage.stageWidth;
			_bg.height = stage.stageHeight;
			
		}
		
		override protected function atRemovedFromStage():void {
			super.atRemovedFromStage();
		}
		
	}
}