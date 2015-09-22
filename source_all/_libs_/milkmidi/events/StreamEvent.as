package milkmidi.events {
	import flash.events.Event;
	[Event(name = "fileLoadComplete", type = "milkmidi.events.StreamEvent")]	
	[Event(name = "fileLoadProgress", type = "milkmidi.events.StreamEvent")]	
	[Event(name = "streamProgress", type = "milkmidi.events.StreamEvent")]
	[Event(name = "streamComplete", type = "milkmidi.events.StreamEvent")]
	//[Event(name = "error", type = "milkmidi.events.StreamEvent")]
	//[Event(name = "metaData", type = "milkmidi.events.StreamEvent")]
	//[Event(name = "play", type = "milkmidi.events.StreamEvent")]
	public class StreamEvent extends Event {			
		public static const STREAM_PROGRESS		:String = "streamProgress";
		public static const STREAM_COMPLETE		:String = "streamComplete";	
		public static const FILE_LOAD_COMPLETE	:String = "fileLoadComplete";
		public static const FILE_LOAD_PROGRESS	:String = "fileLoadProgress";
		//public static const ERROR			:String = "error";
		public static const BUFFER_FULL		:String = "bufferFull";
		//public static const PLAY			:String = "play";
		//public static const META_DATA		:String = "metaData";
		/**
		 * 百分比
		 */
		public var percentage:Number;		
		/**
		 * StreamEvent
		 * @param	pType 類型。
		 * @param	pPercentage 百分比
		 */
		public function StreamEvent(pType:String, pPercentage:Number = 0):void	{				
			super(pType, false, false);			
			percentage = pPercentage;						
		}		
		public override function toString():String {	
			return formatToString("StreamEvent", "type", "percentage");				
		}		
		override public function clone():Event {
			return new StreamEvent(type, 0);									
		}
	}
}