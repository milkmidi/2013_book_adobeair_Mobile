/**
 * @author milkmidi
 */
package com.milkmidi.shake.events {
	import flash.events.Event;
	
	[Event(name = "change", type = "com.milkmidi.shake.events.ShakeEvent")]
	[Event(name = "shake", type = "com.milkmidi.shake.events.ShakeEvent")]
	
	public class ShakeEvent extends Event {
		public static const SHAKE:String = "shake";
		public static const CHANGE:String = "change";

		private var _data:Vector.<Number>;
		public function get data():Vector.<Number>{	return this._data;		}

		public function ShakeEvent(pType:String, pData:Vector.<Number> = null , pBubble:Boolean = false) { 
			super(pType, pBubble, false);
			this._data = pData;
			
		} 
		
		public override function toString():String { 
			return formatToString("ShakeEvent", "type","data"); 
		}
		override public function clone():Event {
			return new ShakeEvent(type,_data, bubbles);			
		}		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package