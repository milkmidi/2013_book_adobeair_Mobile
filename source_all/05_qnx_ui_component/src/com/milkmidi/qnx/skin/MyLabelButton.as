/**
 * @author milkmidi
 */
package com.milkmidi.qnx.skin {		
	import flash.text.TextFormat;
	import qnx.ui.buttons.LabelButton;
	import swc.Label_mc;
	
	public class MyLabelButton extends LabelButton{		
		
		private static var _defaultTextFormat:TextFormat;
		public function MyLabelButton()  {			
			
		}	
		override protected function init():void {			
			if (_defaultTextFormat == null) {
				// 從 swc.Label_mc 裡的 label_txt 取出文字樣式
				var mc:Label_mc = new Label_mc;				
				_defaultTextFormat = mc.label_txt.defaultTextFormat;				
			}
			super.init();
						
			// 更換樣式
			this.setSkin( MyButtonSkin );
		}
		override public function getTextFormatForState(state:String):TextFormat {
			//return super.getTextFormatForState(state);			
			// 依不同的狀態取的相對的文字樣式
			// 在這同一用同一個文字樣式
			return _defaultTextFormat;
		}
		
	}
}