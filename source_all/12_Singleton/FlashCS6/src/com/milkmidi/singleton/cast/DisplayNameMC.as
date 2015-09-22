/**
 * @author milkmidi
 * @date created 2012/10/27/
 */
package com.milkmidi.singleton.cast {		
	import com.milkmidi.singleton.model.Model;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class DisplayNameMC extends Sprite{		
		
		public var user_txt:TextField;
		public function DisplayNameMC()  {			
			Model.getInstance().addEventListener("loginClick" , onModelLoginClickHandler);
		}		
		
		private function onModelLoginClickHandler(e:Event):void {
			user_txt.text = Model.getInstance().myVar;
		}
		
	}
}