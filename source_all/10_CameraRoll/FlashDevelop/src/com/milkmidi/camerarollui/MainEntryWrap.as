/**
 * @author milkmidi
 */
package com.milkmidi.camerarollui {		
	import flash.display.Sprite;
	[SWF(width = "480", height = "800", frameRate = "30", backgroundColor = "#ffffff")]
	public class MainEntryWrap extends Sprite{		
		
		//__________________________________________________________________________________ Constructor
		public function MainEntryWrap()  {			
			addChild( new MainEntry );
		}		
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package