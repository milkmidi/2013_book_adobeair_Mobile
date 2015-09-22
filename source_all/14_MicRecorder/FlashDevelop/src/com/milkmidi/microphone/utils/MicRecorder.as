package com.milkmidi.microphone.utils {
	import com.milkmidi.microphone.events.RecordingEvent;
	import flash.events.EventDispatcher;
	import flash.events.SampleDataEvent;
	import flash.media.Microphone;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
	public class MicRecorder extends EventDispatcher	{
		private var _microphone		:Microphone;
		private var _recordingEvent	:RecordingEvent;
		
		// 記錄麥克風錄音的聲音檔
		private var _buffer:ByteArray = new ByteArray();
		public function get buffer():ByteArray {	return _buffer;		}	
		
		// 得到麥克風裡偵測到的音量
		public function get activityLevel():Number {
			return this._microphone.activityLevel;
		}

		/**
		 * 建立麥克風錄音類別
		 * @param	microphone 麥克風實體物件
		 */
		public function MicRecorder( microphone:Microphone)	{			
			this._microphone = microphone;		
			// 設定麥克風的放大訊號量
			this._microphone.gain = 80;
			// 麥克風擷取聲音的頻率, 以 kHz 為單位
			this._microphone.rate = 44;
			// 建立錄音事件				
			this._recordingEvent = new RecordingEvent( RecordingEvent.RECORDING);			
		}		
	
		/**
		 * 開始錄音
		 */
		public function record():void		{
			trace( "MicRecorder.record" );
			if ( this._microphone == null ) {
				return;
			}					
			// 重新設定 ByteArray 長度與起始值
			this._buffer.length = 0;
			this._buffer.position = 0;			
			// 偵聽麥克風的聲音事件, 好轉存成 ByteArray
			this._microphone.addEventListener(SampleDataEvent.SAMPLE_DATA, onMicSampleDataHandler);
		}
		
		/**
		 * 麥克風聲音事件		 
		 */
		private function onMicSampleDataHandler(e:SampleDataEvent):void {
			// 將從麥克風得到的數據寫入到 _buffer 裡。			
			this._buffer.writeBytes( e.data );		
			
			// 得到己錄音的時間, 
			this._recordingEvent.time = e.position / 44100;			
			
			// 發送事件
			this.dispatchEvent( _recordingEvent );		
		}
		
		/**
		 * 停止錄音
		 */
		public function stop():void {
			trace( "MicRecorder.stop" );
			// 取消偵聽
			_microphone.removeEventListener(SampleDataEvent.SAMPLE_DATA, onMicSampleDataHandler);			
			// 讓 _buffer 數據值回到 0。
			_buffer.position = 0;			
		}
		
		/**
		 * 播放錄音檔
		 */
		public function playRecord():void {
			trace( "MicRecorder.playRecord" );			
			// 當 _buffer 有數據值時, 才做播放的動作
			if (_buffer.bytesAvailable) {			
				// 建立 Sound 物件
				var soundOutput:Sound = new Sound();				
				// 偵聽 Sound 類別的 SampleDataEvent.SAMPLE_DATA 事件
				soundOutput.addEventListener(SampleDataEvent.SAMPLE_DATA, playSoundSampleDataHandler);
				// 播放
				soundOutput.play();  	
			}			
		}		
		/**
		 * 播放聲音事件		 
		 */
		private function playSoundSampleDataHandler(e:SampleDataEvent) : void{           			
            var i:int = 0;
			var n:Number = 0;
            while (i < 4096)       {     
				// 當 _buffer 的裡的有效數值大於 0
                if (  _buffer.bytesAvailable > 0)    {
					// 讀取聲音的數值
                    n = _buffer.readFloat();
                }
				// 播放, 寫入兩一次是因為
				// 一個為左聲道，一個為右聲道
                e.data.writeFloat(n);
                e.data.writeFloat(n);				
                i++;
            }            
        }  			
	}
}