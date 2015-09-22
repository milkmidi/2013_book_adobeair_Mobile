/**
 * @author milkmidi
 */
package milkmidi.events {
	import flash.events.Event;
	
	[Event(name = "sliderDown", type = "milkmidi.events.SliderEvent")]
	[Event(name = "sliderUpDown", type = "milkmidi.events.SliderEvent")]
	[Event(name = "sliderMove", type = "milkmidi.events.SliderEvent")]
	
	public class SliderEvent extends Event {
		public static const SLIDER_DOWN	:String = "sliderDown";
		public static const SLIDER_UP	:String = "sliderUpDown";
		public static const SLIDER_MOVE	:String = "sliderMove";

		private var _value:Number = 0;
		public function get value():*{	return this._value;		}
		
		private var _fromUser:Boolean = false;
		public function get fromUser():Boolean {		return this._fromUser;		}

		public function SliderEvent(pType:String, pValue:Number = 0  , pFromUser:Boolean = false) { 			
			super(pType, false, false);
			this._value = pValue;
			this._fromUser = pFromUser;
			
		} 
		
		public override function toString():String { 
			return formatToString("SliderEvent", "type","value","fromUser"); 
		}
		override public function clone():Event {
			return new SliderEvent(type, value, fromUser);						
		}		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package