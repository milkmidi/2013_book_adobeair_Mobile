/**
 * @author milkmidi
 */
package com.milkmidi.qnx.views {		
	import milkmidi.qnx.view.View;
	import qnx.ui.core.Container;
	import qnx.ui.core.Containment;
	import qnx.ui.text.Label;
	
	public class BasicLayout extends View {		
		
		
		//__________________________________________________________________________________ Constructor
		public function BasicLayout()  {			
			
		}	
		override protected function init():void {
			super.init();			
			this.margins = new <Number>[10,10,10,10];
			this.debugColor = 0x111111;
			//this.flow = ContainerFlow.HORIZONTAL;
			
			var top:Container = obtainContainer( "top", 0xff0000);				
			top.size = 100;
			//top.sizeUnit = SizeUnit.PIXELS;			
			//top.containment = Containment.BACKGROUND;		
			addChild( top );
			
			var mid:Container = obtainContainer( "middle", 0x00ff00);			
			addChild( mid );
			
			var bottom:Container = obtainContainer( "bottom", 0x0000ff);
			addChild( bottom );
		}
		
		private function obtainContainer( text:String, color:uint ):Container {
			var con:Container = new Container();
			con.debugColor = color;
			con.margins = new <Number>[15,15,15,15];			
			
			var label:Label = new Label();			
			label.text = text;
			con.addChild( label );
			return con;
		}
		
	}
}