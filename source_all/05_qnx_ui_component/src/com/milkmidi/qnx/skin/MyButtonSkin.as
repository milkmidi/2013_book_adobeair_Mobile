/**
 * @author milkmidi
 */
package com.milkmidi.qnx.skin {		
	import flash.display.Sprite;
	import qnx.ui.skins.SkinStates;
	import qnx.ui.skins.UISkin;
	import swc.Button_mc_BG_mc;
	import swc.Button_mc_PressBG_mc;
	
	public class MyButtonSkin extends UISkin{			
		public function MyButtonSkin()  {			
		}			
		override protected function initializeStates():void {
			// swc 裡的元件
			var _up:Sprite = new Button_mc_BG_mc;
			_up.cacheAsBitmap = true;			
			// 指定當一般狀態時, 使用 _up 元件
			setSkinState( SkinStates.UP , _up);
			
			// swc 裡的按下元件
			var _down:Sprite = new Button_mc_PressBG_mc;
			_down.cacheAsBitmap = true;
			// 指定當按下狀態時, 使用 _down 元件
			setSkinState( SkinStates.DOWN , _down);
			
			// 預設裝態為 _up 元件
			showSkin( _up );
		}	
	}
}