/**
 * @author milkmidi
 */
package com.milkmidi.microphone.cast {		
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import milkmidi.display.MSprite;
	import milkmidi.utils.SimpleButtonProxy;
	
	[Embed(source="../../../../../fla/micRecorderAssets.swf", symbol="swc.Controller_mc")]
	public class ControllerMC extends MSprite {		
		// 定義常數字串, 避免打錯字的問題
		public static const RECORD	:String = "record";
		public static const STOP	:String = "stop";
		public static const PLAY	:String = "play";
		public static const SAVE	:String = "save";
		
		// 使用 Embed 時, 物件裡的名稱要重新宣告一次
		public var record_mc    :MovieClip;
		public var stop_mc      :MovieClip;
		public var play_mc      :MovieClip;
		public var save_mc      :MovieClip;		
	
		//__________________________________________________________________________________ Constructor
		public function ControllerMC()  {			
			// 加入簡單按鈕功能, 並偵聽 CLICK 事件
			new SimpleButtonProxy( this.record_mc ).addClick( onMouseClickHandler);
			new SimpleButtonProxy( this.stop_mc ).addClick( onMouseClickHandler);
			new SimpleButtonProxy( this.play_mc ).addClick( onMouseClickHandler);
			new SimpleButtonProxy( this.save_mc ).addClick( onMouseClickHandler);			
			// 先讓其他的按鈕隱藏
			stop_mc.visible = false;
			play_mc.visible = false;
			save_mc.visible = false;
		}			
		private function onMouseClickHandler( e:MouseEvent ):void {
			//trace( e.currentTarget.name + " click");
			switch (e.currentTarget) {
				case record_mc:
					// 按下錄音按鈕
					dispatchEvent( new Event( RECORD ));					
					record_mc.visible = false;
					stop_mc.visible = true;					
					play_mc.visible = false;
					save_mc.visible = false;
					break;
				case stop_mc:
					// 按下停止錄音按鈕
					dispatchEvent( new Event( STOP ));					
					record_mc.visible = true;
					stop_mc.visible = false;
					play_mc.visible = true;
					save_mc.visible = true;					
					break;
				case play_mc:
					// 按下播放錄音按鈕
					dispatchEvent( new Event( PLAY ));						
					break;
				case save_mc:
					// 按下存檔按鈕
					dispatchEvent( new Event( SAVE ));
					break;
			}
		}
		
	}
}
