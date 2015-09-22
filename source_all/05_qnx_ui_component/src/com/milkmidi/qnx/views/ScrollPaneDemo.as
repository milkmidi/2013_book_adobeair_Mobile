package com.milkmidi.qnx.views {
	import milkmidi.qnx.view.View;
	import qnx.ui.core.Container;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.listClasses.ScrollPane;
	/**
	 * ...
	 * @author milkmidi
	 */
	public class ScrollPaneDemo extends View {
        
		[Embed(source="../../../../assets/1680x1050.jpg")]
        public static var BIG_IMAGE:Class;
		
		public function ScrollPaneDemo() {
			super();				
		}
		override protected function init():void {
			super.init();
		
			this.margins = new <Number>[20,20,20,20];					
			this.debugColor = 0x00ffff;			
		
			var scrollPane:ScrollPane = new ScrollPane();		
			scrollPane.sizeUnit = SizeUnit.PERCENT;
			scrollPane.size = 100;				 
            scrollPane.setScrollContent( BIG_IMAGE );                        
            addChild(scrollPane);			
		}
		
	}

}