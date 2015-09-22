/**
 * @author milkmidi
 */
package com.milkmidi.stagevideo {		
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import com.milkmidi.stagevideo.media.SimpleStageVideo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import milkmidi.display.MSlider;
	import milkmidi.display.MSprite;
	import milkmidi.events.SliderEvent;
	import milkmidi.events.StreamEvent;
	import milkmidi.utils.DeviceUtil;
	
	[Embed(source = "../../../../fla/SimpleStageVideoAssets.swf", symbol = "swc.MediaPlayerController_mc")]	
	public class ControllBarMC extends MSprite {		
		
		// 用來顯示影片長度的文字物件
		public var totalTime_txt	:TextField;
		// 用來顯示目前播放進度的文字物件
		public var currentTime_txt	:TextField;		
		// 播放與暫停鍵
		public var playPause_mc 	:MovieClip;
 
		// SimpleStageVideo 物件
		private var _player			:SimpleStageVideo;		
		
		//__________________________________________________________________________________ Constructor
		public function ControllBarMC(pPlayer:SimpleStageVideo)  {						
			super();					
			this.playPause_mc.gotoAndStop(1);
			
			this._player = pPlayer;			
			this._player.addEventListener(SimpleStageVideo.STATUS_CHANGE , onPlayStatusChangeHandler);
			
			this.playPause_mc.overlay_mc.visible = false;
			this.playPause_mc.addEventListener(MouseEvent.MOUSE_DOWN , onPlayPauseDownHandler);			
			this.addEventListener(Event.ENTER_FRAME , onEnterFrameHandler);
		}			
		private function onEnterFrameHandler(e:Event):void {
			totalTime_txt.text = _player.getTotalTimeCode();
			currentTime_txt.text = _player.getCurrentTimeCode();
		}
		private function onPlayPauseDownHandler(e:MouseEvent):void {
			// 播放按鈕按下時
			playPause_mc.overlay_mc.visible = true;
		
			stage.addEventListener(MouseEvent.MOUSE_UP , function ():void {
				// 放開時
				stage.removeEventListener( MouseEvent.MOUSE_UP , arguments.callee);
				playPause_mc.overlay_mc.visible = false;
				
				// 切換影片的播放狀態
				_player.togglePause();
			});
		}			
		private function onPlayStatusChangeHandler(e:Event):void {			
			switch (_player.status) {
				case SimpleStageVideo.PAUSED:
				case SimpleStageVideo.STOPPED:
					// 當影片是暫停或是停止時
					playPause_mc.gotoAndStop(1);
					break;
				case SimpleStageVideo.PLAYING:
					// 影片是播放時
					playPause_mc.gotoAndStop(2);
					break;					
			}			
		}		
		override protected function atResize():void {
			// 讓播放器物件水平置中, 對齊場景的高度
			this.x = stage.stageWidth >> 1;
			this.y = stage.stageHeight;// - DeviceUtil.actionBarHeight;
		}
		override protected function atRemovedFromStage():void {
			super.atRemovedFromStage();
			this.removeEventListener(Event.ENTER_FRAME , onEnterFrameHandler);
			this._player.removeEventListener(SimpleStageVideo.STATUS_CHANGE , onPlayStatusChangeHandler);			
			this.playPause_mc.removeEventListener(MouseEvent.MOUSE_DOWN , onPlayPauseDownHandler);			
			//_player.destroy();
			_player = null;
		}
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package