package milkmidi.qnx.view {
	import flash.geom.Rectangle;
	import qnx.ui.core.Container;
	import qnx.ui.core.InvalidationType;
	/**
	 * ...
	 * @author milkmidi
	 */
	public class ViewContainer extends Container {
		
		public function ViewContainer( s:Number = 100 , su:String = "percent" ) {
			super( s , su );
		}
		
		
		
		override protected function draw():void {
			
			
			if ( isInvalid( InvalidationType.SIZE )) {
				if (width != 0 && height !=0) {
					this.scrollRect = new Rectangle(0, 0, width, height);										
				}				
			}
			
			//trace( isInvalid( InvalidationType.SIZE ),width,height );
			super.draw();
		}
	
	}

}