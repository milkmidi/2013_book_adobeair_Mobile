/**
 * @author milkmidi
 */
package com.milkmidi.drawpencil.model {
	import flash.events.Event;
	
	public class PencilEvent extends Event {
		// 色彩改變時
		public static const COLOR_CHANGE		:String = "colorChange";
		// 色盤出現時
		public static const COLOR_PICKER_SHOW	:String = "colorPickerShow";
		// 色盤消失時
		public static const COLOR_PICKER_HIDE	:String = "colorPickerHide";
		
		public function PencilEvent( pType:String ) {
			super( pType, false, false );
		}
	
	}
}