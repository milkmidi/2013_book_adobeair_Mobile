/**
 * @author milkmidi
 * @date created 2012/06/09/
 */
package com.milkmidi.qnx.views {		
	import flash.events.Event;
	import flash.events.MouseEvent;
	import milkmidi.managers.DialogManager;
	import milkmidi.qnx.dialogs.ListDialog;
	import milkmidi.qnx.view.View;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.core.Container;
	import qnx.ui.core.SizeUnit;
	
	public class DialogView extends View{		
		
		//__________________________________________________________________________________ Constructor
		public function DialogView()  {			
			
			this.addEventListener(Event.ADDED_TO_STAGE , onAddedToStageHandler);
		}		
		
		private function onAddedToStageHandler(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			DialogManager.init( stage);
		}
		override protected function init():void {
			trace( "DialogView.init" );
			super.init();
			var btn:LabelButton = new LabelButton();
			btn.size = 50;
			btn.sizeMode = SizeUnit.PIXELS;
			btn.label = "Label Button";
			
			
			
			var a:Array = [];
			for (var i:int = 0; i < 100; i++) {
				a.push( i +"");
			}
			
			
			
			btn.addEventListener(MouseEvent.CLICK , function ():void {
				DialogManager.showDialog( new ListDialog( 600, 360, "Select", a));				
				
			});
			addChild(btn);
			
			//addChild( new ListDialog( 800, 600, "Select",a ) );
		}
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package