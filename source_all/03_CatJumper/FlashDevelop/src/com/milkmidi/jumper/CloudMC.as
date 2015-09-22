/**
 * @author milkmidi
 */
package com.milkmidi.jumper {		
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	
	public class CloudMC extends Cloud_mc {				
		
		// 指定中心點 x 軸
		public var centerX:int;
		public function CloudMC()  {			
			addEventListener(Event.ENTER_FRAME , onEnterFrameHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemovedFromStageHandler);
		}		
		
		private function onRemovedFromStageHandler(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler);
			removeEventListener(Event.ENTER_FRAME , onEnterFrameHandler);
		}
		
		private function onEnterFrameHandler(e:Event):void {
			// getTimer() 可以得到目前 swf 啟動後經過的時間, 單元為毫秒
			var timer:Number = getTimer() / 1000;
			// 因為數值過大, 所以除以 1000
			// 使用 sin 函式, 當 timer 數值越大, 就可以產生 -1 到 1 的範圍值
			// 乘上 30 , 就可以得到 -30 ~ 30 的數值, 再加上中心點 x 軸即可
			this.x = Math.sin( timer ) * 30 + centerX;
		}
		
	}
}