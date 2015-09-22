/**
 * @author milkmidi
 */
package com.milkmidi.microphone.worker {		
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.utils.ByteArray;
	import fr.kikko.lab.ShineMP3Encoder;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	
	public class BackWorker {		
		private var _backToMain	:MessageChannel;
		private var _mainToBack	:MessageChannel;
		private var _mp3Encoder	:ShineMP3Encoder;
		//__________________________________________________________________________________ Constructor
		public function BackWorker()  {			
	
			
			_backToMain = Worker.current.getSharedProperty("backToMain");
			_mainToBack = Worker.current.getSharedProperty("mainToBack");			
			_mainToBack.addEventListener(Event.CHANNEL_MESSAGE, onMainToBackHandler);
			_backToMain.send( ["BackWorker Constructor"] );
		}		
		
		private function onMainToBackHandler(e:Event):void {
			
			var msg:* = _mainToBack.receive();			
			if (msg[0] == "startEncoder") {				
				try {					
					var byte:ByteArray = msg[1];
					byte.position = 0;				
					var waveByte:ByteArray = new WaveEncoder().encode( byte, 1 );					
					var mp3Encoder:ShineMP3Encoder = new ShineMP3Encoder( waveByte );
					
					_mp3Encoder = new ShineMP3Encoder(waveByte);
					_mp3Encoder.addEventListener(Event.COMPLETE, onMP3EncodeCompleteHandler);
					_mp3Encoder.addEventListener(ProgressEvent.PROGRESS, onMP3EncodeProgressHandler);
					_mp3Encoder.start();
				}catch (err:Error){
					_backToMain.send( err.message );
				}								
			}
			
			
		}
		
		private function onMP3EncodeProgressHandler(e:ProgressEvent):void {
			var percent:int = e.bytesLoaded / e.bytesTotal * 100;
			_backToMain.send(["encoderProgress", percent]);					
		}		
		private function onMP3EncodeCompleteHandler(e:Event):void {		
			_backToMain.send( [ "encoderComplete" , _mp3Encoder.mp3Data ] );			
			_mp3Encoder.removeEventListener(Event.COMPLETE, onMP3EncodeCompleteHandler);
			_mp3Encoder.removeEventListener(ProgressEvent.PROGRESS, onMP3EncodeProgressHandler);
			_mp3Encoder = null;
		}
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package