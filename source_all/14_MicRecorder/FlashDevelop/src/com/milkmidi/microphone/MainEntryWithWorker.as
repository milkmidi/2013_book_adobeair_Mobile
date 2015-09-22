/**
 * FlashPlayer 11.4 限定, 使用 Worker 多執行序工作
 * @author milkmidi
 */
package com.milkmidi.microphone {
	import com.milkmidi.microphone.cast.ControllerMC;
	import com.milkmidi.microphone.worker.BackWorker;
	import flash.display.*;
	import flash.events.*;
	import flash.net.FileReference;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.utils.ByteArray;
	import milkmidi.qnx.display.Toast;
	import swc.Loading_mc;
	
	//[SWF( width = "800", height = "480", frameRate = "30", backgroundColor = "#000000" )]	
	[SWF( width = "960", height = "640", frameRate = "30", backgroundColor = "#000000" )]	
	
	public class MainEntryWithWorker extends MainEntry {
		
		private var _backToMain	:MessageChannel;
		private var _mainToBack	:MessageChannel;
		private var _worker		:Worker;
		private var _loading	:Loading_mc;
		
		public function MainEntryWithWorker() {
			if ( Worker.current.isPrimordial ) {
				_worker = WorkerDomain.current.createWorker( this.loaderInfo.bytes );
				_backToMain = _worker.createMessageChannel( Worker.current );
				_mainToBack = Worker.current.createMessageChannel( _worker );
				
				_worker.setSharedProperty( "backToMain" , _backToMain );
				_worker.setSharedProperty( "mainToBack" , _mainToBack );
				
				_backToMain.addEventListener( Event.CHANNEL_MESSAGE , onBackToMainHandler );
				
				_worker.start();
				
				
			} else {
				
				new BackWorker();
			}
		}
		
		private function onBackToMainHandler(e:Event):void {
			trace( "messageAvailable:" + _backToMain.messageAvailable);			
			if ( !_backToMain.messageAvailable ) {
				return;
			}
			var msg:* = _backToMain.receive();
			try {
				trace( "BackToMain:" + msg[0] );							
			}catch (err:Error){
			
			}
			
			
			switch ( true ) {
				case msg[0] == "encoderProgress":		
					
					if (_loading == null) {
						_loading = new Loading_mc;
						addChild( _loading );
					}					
					_loading.label = "BUFFER " + msg[1] + "%";
					break;
				case msg[0] == "encoderComplete":	
					removeChild( _loading );
					_loading = null;			
				
					Toast.makeText( stage , "Complte" ).show();
				
					var mp3Bytes:ByteArray = _backToMain.receive();				
					new FileReference().save( msg[1], getFileName() + ".mp3");   			
					break;
			}
		
		}
		
		override protected function doSaveSound():void {						
			try {
				_mainToBack.send(["startEncoder", _micRecorder.buffer]);													
			}catch (err:Error) {
				Toast.makeText( stage, err.message ).show();
				trace( err );				
			}			
		}
	
	}
}

