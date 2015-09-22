/**
 * @author milkmidi
 */
package com.milkmidi.singleton {		
	import com.milkmidi.singleton.model.Model;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class MainEntry extends Sprite {		
		// 場景上的元件
		public var loginBtn_mc  :MovieClip;

		public function MainEntry()  {			
			
			loginBtn_mc.addEventListener(MouseEvent.CLICK , onLoginClickHandler);
			
			
			
			Model.getInstance().addEventListener("loginClick" , onModelLoginClickHandler);
		}		
		
		/* 本來的直覺式寫法
		private function onLoginClickHandler(e:MouseEvent):void {
			loginBtn_mc.label_txt.text = "LOGOUT";
			包了 N 層的左上角物件因為沒有取實體名稱
			要得最裡面的文字, 就相當的麻煩
		}
		*/
		
		// 使用 Singleton Model 寫法
		private function onLoginClickHandler(e:MouseEvent):void {
			// 更改 Model 裡的變數
			Model.getInstance().myVar = "milkmidi";
			// 由 Model 發送一個名為 loginClick 的事件
			Model.getInstance().dispatchEvent( new Event("loginClick"));			
		}
		private function onModelLoginClickHandler(e:Event):void {
			loginBtn_mc.label_txt.text = "LOGOUT";
		}
	}
}