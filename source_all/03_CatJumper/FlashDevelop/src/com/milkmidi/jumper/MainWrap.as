/**
 * @author milkmidi
 * @date created 2012/12/02/
 */
package com.milkmidi.jumper {		
	import flash.display.Sprite;
	
	public class MainWrap extends Sprite {		
		
		//__________________________________________________________________________________ Constructor
		public function MainWrap()  {			
			
			//stage.align = 'tl';
			//stage.scaleMode = 'noScale';
			addChild( new MainEntry2);
		}		
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package