/**
 * @author milkmidi
 * @date created 2012/07/15/
 */
package com.milkmidi.qnx.views {		
	import milkmidi.qnx.view.View;
	import qnx.ui.core.Container;
	import qnx.ui.slider.Slider;
	import qnx.ui.slider.VolumeSlider;
	
	public class SliderDemo extends View{		
		
		//__________________________________________________________________________________ Constructor
		public function SliderDemo()  {			
			
		}		
		override protected function init():void {
			super.init();
			
			var slider:Slider = new Slider;
			addChild( slider );
			
			var volSlider:VolumeSlider = new VolumeSlider;
			addChild(volSlider);
		}
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package