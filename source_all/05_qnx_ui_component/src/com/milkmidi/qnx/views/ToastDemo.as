/**
 * @author milkmidi
 */
package com.milkmidi.qnx.views {		
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import milkmidi.qnx.display.Toast;
	import milkmidi.qnx.view.View;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.core.Container;
	import qnx.ui.skins.SkinStates;
	
	public class ToastDemo extends View{		
		
		//__________________________________________________________________________________ Constructor
		public function ToastDemo()  {			
			
		}		
		override protected function init():void {
			super.init();
			
			
			var btn:LabelButton = new LabelButton();
			btn.label = "按我";
			
			var tf:TextFormat = new TextFormat( null , 30 );
			btn.setTextFormatForState( tf , SkinStates.UP );
			btn.setTextFormatForState( tf , SkinStates.DOWN );
			btn.addEventListener(MouseEvent.CLICK , onClickHandler);
			addChild( btn );
		}
		
		private function onClickHandler(e:MouseEvent):void {
			Toast.makeText( stage , "中文測試").show();
		}
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package