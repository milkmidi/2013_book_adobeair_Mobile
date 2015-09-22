/**
 * @author milkmidi
 */
package com.milkmidi.singleton.cast {		
	import com.milkmidi.singleton.model.Model;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class AnimationMC extends MovieClip {		
	
		public function AnimationMC()  {	
			// 該此物件隱藏
			this.visible = false;
			// 暫停影格
			this.stop();
			// 偵聽 Model loginClick 事件
			Model.getInstance().addEventListener("loginClick" , onModelLoginHandler);
			// 動態新增程式碼在指定的影格上
			this.addFrameScript( this.totalFrames - 1, addNScript);
		}				
		private function addNScript():void {
			stop();
		}		
		private function onModelLoginHandler(e:Event):void {
			this.visible = true;
			this.gotoAndPlay(1);
		}
		
	}
}