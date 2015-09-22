/**
 * @author milkmidi
 * @see http://milkmidi.blogspot.com
 */
package milkmidi.media{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	[Event(name="stopSound", type="milkmidi.media.BasePlayer")]
	[Event(name="playSound", type="milkmidi.media.BasePlayer")]
	public class BasePlayer extends EventDispatcher	{
		
		static public const BYTES_PER_CALLBACK:int = 4096; //有效值 >= 2048 && < = 8192 
		static public const PLAY_SOUND:String = "playSound";
		static public const STOP_SOUND:String = "stopSound";
		
		/**
		 * 播放的速度
		 */
		private var _playbackSpeed:Number = 1;		
		public function get playbackSpeed():Number {	return  this._playbackSpeed;		}		
		public function set playbackSpeed(value:Number):void{			
			_playbackSpeed = value;
		}
		
		/**
		 * 來源的聲音
		 */
		private var _sourceSound	:Sound;
		public function get sourceSound():Sound {		return  this._sourceSound;		}
		
		private var _soundChannel:SoundChannel;
		
		/**
		 * 特效用的聲音
		 */
		protected var _sampleSound	:Sound;
		
		protected var _numSamples		:int;
		public function get numSamples():int {		return  this._numSamples;		}
		
		/**
		 * 特效用的ByteArray
		 */
		protected var _samplesData	:ByteArray;
		public function get samplesData():ByteArray {	return this._samplesData;		}				
		
		
		public function BasePlayer() {
			
		}
		/**
		 * 載入 Sound 類別, Embed 或是己經在 Flash Library 裡的
		 * @param	pSound
		 */
		public function loadSound( pSound:Sound ):void {
			_sourceSound = pSound;
			_numSamples = int(_sourceSound.length * 44.1);	
			trace( "BasePlayer.loadSound > _numSamples : " + _numSamples );
			onSoundLoadComplete( null );
		}		
		/**
		 * 載入錄音時的 ByteArray 格式
		 * @param	pSamplesData
		 
		public function playBytes(pSamplesData:ByteArray):void {
			_sourceSound = new Sound();
			_samplesData = pSamplesData;
			_numSamples = pSamplesData.length / 8;
			trace( "BasePlayer.playBytes > _numSamples:" + _numSamples );			
			play();
		}*/
		/**
		 * 從連結載入聲音檔
		 * @param	pURL
		 */
		public function load( pURL:String ):void		{			
			trace( "BasePlayer.load > pURL : " + pURL );
			_sourceSound = new Sound();
			_sourceSound.addEventListener(Event.COMPLETE, onSoundLoadComplete);
			_sourceSound.load( new URLRequest( pURL ));
		}		
		protected function onSoundLoadComplete(e:Event):void {			
			_numSamples = int(_sourceSound.length * 44.1);					
			trace( "BasePlayer.onSoundLoadComplete > _numSamples : " + _numSamples );
			play();
		}		
		/**
		 * 播放聲音
		 */
		public function play():void {			
			trace( "BasePlayer.play" );
			if (_sampleSound) {
				stop();
			}
			_sampleSound = new Sound();
			_sampleSound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);		
			_soundChannel = _sampleSound.play();
			dispatchEvent(new Event( PLAY_SOUND ));
		}
		/**
		 * 暫停聲音
		 */
		public function stop():void {
			trace( "BasePlayer.stop" );
			if (_soundChannel) {
				_soundChannel.stop();				
			}
			if (_sampleSound) {
				_sampleSound.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
				_sampleSound = null;				
			}
			dispatchEvent(new Event( STOP_SOUND ));
		}					
	
		private var _phase:Number = 0;
		protected function onSampleData(e:SampleDataEvent):void {			
			var l:Number;
			var r:Number;
			var p:int;
			var loadedSamples:ByteArray = new ByteArray();
			var startPosition:int = int(_phase);
			sourceSound.extract(loadedSamples, BYTES_PER_CALLBACK * playbackSpeed, startPosition);
			loadedSamples.position = 0;
			
			while (loadedSamples.bytesAvailable > 0) {				
				p = int(_phase - startPosition) * 8;				
				if (p < loadedSamples.length - 8 && e.data.length <= BYTES_PER_CALLBACK * 8) {
					
					loadedSamples.position = p;
					
					l = loadedSamples.readFloat();
					r = loadedSamples.readFloat();
					
					e.data.writeFloat(l);
					e.data.writeFloat(r);					
				}
				else {
					loadedSamples.position = loadedSamples.length;
				}				
				_phase += playbackSpeed;				
				// loop
				if (_phase >= numSamples){
					_phase -= numSamples;
					break;
				}
			}			
		}
	}
}

