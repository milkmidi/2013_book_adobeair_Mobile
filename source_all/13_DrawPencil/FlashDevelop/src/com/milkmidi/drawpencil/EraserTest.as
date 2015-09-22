/*
* @author milkmidi
* http://milkmidi.blogspot.com
*/
package com.milkmidi.drawpencil {
	
	import com.milkmidi.drawpencil.cast.CanvasWithEarserMC;
	import flash.display.*;
	import flash.events.MouseEvent;
	import milkmidi.qnx.display.QnxMain;
	import milkmidi.qnx.utils.QNXFactory;
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.core.Containment;
	import qnx.ui.core.SizeUnit;
	[SWF(width = "480", height = "800", frameRate = "30", backgroundColor = "#dddddd")]
	public class EraserTest extends QnxMain{
		
	
		private var _canvas:CanvasWithEarserMC;
		public function EraserTest() {
			super( false );			
		}
		override protected function createChildren():void {
			
			addChildAt( _canvas = new CanvasWithEarserMC, 0);			
			
			var btnContainer:Container = new Container(50 , SizeUnit.PIXELS);
			btnContainer.flow = ContainerFlow.HORIZONTAL;
			btnContainer.containment = Containment.DOCK_BOTTOM;
			container.addChild( btnContainer );
			
			var prop:Object = { size:100, sizeUnit:SizeUnit.PERCENT };			
			QNXFactory.labelButton( btnContainer , "Draw", onClickHandler , prop);
			QNXFactory.labelButton( btnContainer , "Earser", onClickHandler , prop);			
		}
		
		private function onClickHandler(e:MouseEvent):void {
			// 更換工具
			_canvas.tool = e.currentTarget.label;
		}
		
		
	
	}

}