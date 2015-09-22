package com.milkmidi.microphone.events {
	import flash.events.Event;
	
	public class RecordingEvent extends Event {
		public static const RECORDING:String = "recording";		
		
		// 記錄錄音的時間
		private var _time:Number;				
		public function get time():Number {		return _time;		}		
		public function set time(value:Number):void {
			_time = value;
		}		
		public function RecordingEvent( pType:String, pTime:Number = 0)		{
			super(pType, false, false);
			_time = pTime;
		}		
		public override function clone(): Event {
			return new RecordingEvent(type, _time);			
		}
	}
}