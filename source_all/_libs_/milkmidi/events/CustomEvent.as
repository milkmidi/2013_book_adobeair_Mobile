package milkmidi.events {	
	import flash.events.Event;	
	
	public class CustomEvent extends Event {		
		
		public static const CHANGE:String = "change";
		
		private var _data:Object;
		public function get data():Object {	return _data;		}
		
		public function CustomEvent(pType:String, pData:Object = null , pBubbles:Boolean = false, pCancelable:Boolean = false) {									
			super(pType, pBubbles, pCancelable);						
			_data = pData;
		}		
		public override function toString():String { 
			return formatToString("CustomEvent", "type", "data");			
		}
		
		override public function clone():Event {
			return new CustomEvent( type , data );
		}
		
		
	}
}