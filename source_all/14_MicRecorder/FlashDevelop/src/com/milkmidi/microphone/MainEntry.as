/**
 * @author milkmidi
 * @see http://milkmidi.blogspot
 */
package com.milkmidi.microphone {		
	import com.milkmidi.microphone.cast.ControllerMC;
	import com.milkmidi.microphone.events.RecordingEvent;
	import com.milkmidi.microphone.utils.MicRecorder;
	import flash.display.*;
	import flash.events.*;
	import flash.media.Microphone;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import fr.kikko.lab.ShineMP3Encoder;
	import milkmidi.display.MApplication;
	import milkmidi.display.MSprite;
	import milkmidi.qnx.display.Toast;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	import swc.Activity_mc;
	import swc.Loading_mc;
	import swc.Time_mc;
	CONFIG::air{
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		import flash.filesystem.FileStream;
	}
	
	[SWF(width = "800", height = "480", frameRate = "30", backgroundColor = "#000000")]			
	public class MainEntry extends MApplication {	
		// 麥克風錄音物件
		protected var _micRecorder	:MicRecorder;				
		// 用來顯示目前的錄音時間
		private var _timeMC			:Time_mc;		
		// 控製元件
		private var _controller		:ControllerMC;		
		// 用來顯示目前的麥克風音量
		private var _activity		:Activity_mc;		
		// 背景色塊
		private var _bg				:Bitmap;
		
		public function MainEntry()  {	
		}		
		override protected function atAddedToStage():void {
			super.atAddedToStage();
			
			// 建立控製元件
			addChild( _controller = new ControllerMC);
			// 偵聽子按鈕發出的事件
			_controller.addEventListener( ControllerMC.RECORD , onControllerMCHandler);
			_controller.addEventListener( ControllerMC.STOP , onControllerMCHandler);
			_controller.addEventListener( ControllerMC.PLAY , onControllerMCHandler);
			_controller.addEventListener( ControllerMC.SAVE , onControllerMCHandler);
		
			// 建立麥克風音量的可視物件
			addChild( _activity = new Activity_mc);
			// 暫時先隱藏
			_activity.visible = false;
		
		
			// 建立顯用錄音時間用的可視物件
			addChild( _timeMC = new Time_mc);
			_timeMC.time_txt.text = "00";
			_timeMC.mouseChildren = false;
			_timeMC.x = 30;
			_timeMC.y = 16;
			_timeMC.visible = false;
			
			// 得到裝置上的麥克風
			var _mic:Microphone = Microphone.getMicrophone();
			
			if (_mic) {
				// 建立麥克風錄音物件
				_micRecorder = new MicRecorder(  _mic );					
				// 偵聽麥克風錄音時間事件
				_micRecorder.addEventListener(RecordingEvent.RECORDING, function (e:RecordingEvent):void {				
					// 得到的時間小數點會很長, 這時可以使用 toFixed( 要顯示的位數 )
					_timeMC.time_txt.text = e.time.toFixed(2);				
				});
				
			}else {
				Toast.makeText( stage , "請安裝麥克風!").show();
				_controller.visible = false;
			}
			
			
		
			// 建立背景色塊用的 BitmapData, 寬、高皆為 1
			var bgColor:BitmapData = new BitmapData( 1, 1, false, 0xF1F4F5);			
			_bg = new Bitmap( bgColor );
			// 加入至場景的最下層
			addChildAt( _bg, 0 );		
			
			CONFIG::air{
			stage.setAspectRatio( StageAspectRatio.LANDSCAPE );
			}
		}
		
		/**
		 * 偵聽控製元件所發出的事件		 
		 */
		private function onControllerMCHandler(e:Event):void {
			trace( "onControllerMCHandler:" + e.type );			
			// 移除麥克風音量偵聽事件
			removeEventListener(Event.ENTER_FRAME , onMicActivityHandler);			
			switch (e.type) {
				case ControllerMC.RECORD:
					// 按下錄音按鈕時					
					// 顯示錄音時間及音量物件
					_timeMC.visible = true;					
					_activity.visible = true;
					// 偵聽麥克風音量事件
					addEventListener(Event.ENTER_FRAME , onMicActivityHandler);
					// 開始錄音
					_micRecorder.record();
					break;
				case ControllerMC.STOP:
					// 停止錄音
					_micRecorder.stop();
					break;
				case ControllerMC.PLAY:
					// 播放錄音
					_micRecorder.playRecord();		
					break;
				case ControllerMC.SAVE:					
					// 存檔
					doSaveSound();					
					break;
			}
		}
		/**
		 * 偵聽麥音風音量事件		 
		 */
		private function onMicActivityHandler(e:Event):void {
			// 麥音風音量有效值為 0 ~ 100			
			_activity.bar_mc.scaleX = _micRecorder.activityLevel * 0.01;			
		}
		protected function doSaveSound():void {
			// 顯示載入進度元件
			var loading:Loading_mc = new Loading_mc;
			addChild( loading );
			
			// 使用 WaveEncoder 類別, 將麥克風錄音資訊編碼成 WAV 格式
			var waveByte:ByteArray = new WaveEncoder().encode( _micRecorder.buffer, 1 );			
			
			// 再將 WAV 格式轉存成 MP3 格式
			var mp3Encoder:ShineMP3Encoder = new ShineMP3Encoder( waveByte );					
			// 偵聽轉換進度
			mp3Encoder.addEventListener(ProgressEvent.PROGRESS, function (e:ProgressEvent):void {				
				loading.label = "BUFFER" + int(e.bytesLoaded / e.bytesTotal * 100) + "%";
			});
			// 偵聽轉換完成事件
			mp3Encoder.addEventListener(Event.COMPLETE, function (e:Event):void {					
				// 移除事入進度元件
				removeChild( loading );
				// 存檔
				doSaveMP3File( mp3Encoder.mp3Data );							
			});
			// 開始編碼
			mp3Encoder.start();              
		}
		
		/**
		 * AIR 版, 使用 File 類別直接將檔案寫入
		 * @param	mp3Data
		 */		
		CONFIG::air
		private function doSaveMP3File(mp3Data:ByteArray):void {		
			// File.documentsDirectory
			// 在 PC 上會得到使用者 我的文件路徑
			// 在 Android 上, 會得到 SD 卡的路徑 
			// 建立 milkmidi_file 資料夾
			var folderFile:File = File.documentsDirectory.resolvePath("milkmidi_file");  	
			// 如果資料夾不存在
			if (!folderFile.exists) {
				try {  
					//建立資料夾
					folderFile.createDirectory();  
				} catch (err:Error) {  
					trace( err );
				}  
			}
			// 檔名
			var fileName:String = getFileName() + ".mp3";
			// 要儲存的路徑
			var myFile:File = File.documentsDirectory.resolvePath("milkmidi_file/" + fileName);  			
			// 如果檔案已存在
			if (myFile.exists) {				
				// 刪除舊檔
				myFile.deleteFile();
			}	
			try {
				// 使用 FileStream 寫入檔案
				var fs:FileStream = new FileStream();  		
				fs.open(myFile, FileMode.WRITE);  		
				fs.writeBytes( mp3Data, 0 , mp3Data.length );
				fs.close();  					
				Toast.makeText( stage , "Save Success"  ).show();					
			}catch (err:Error){
				trace( err );
			}
		}
		
		/**
		 * SWF 版, 使用 FileReference 出現存檔的對話框讓使用者選擇		 
		 */
		CONFIG::swf
		private function doSaveMP3File(mp3Data:ByteArray):void {				
			new FileReference().save(mp3Data, getFileName() + ".mp3");   	
		}
		
		protected static function getFileName():String {
			return "milkmidi_recod_" + new Date().getMilliseconds();
		}
		
	
		override protected function atResize():void {
			super.atResize();			
			
			_activity.width = stage.stageWidth;
			_activity.y = stage.stageHeight -53;					
			
			var bgHeight:int = stage.stageHeight -56;			
			_bg.width = stage.stageWidth;
			_bg.height = bgHeight;		
			_controller.x = stage.stageWidth >> 1;		
			_controller.y = bgHeight >> 1;
		}
		
		override protected function atRemovedFromStage():void {
			super.atRemovedFromStage();
			_controller.removeEventListener( ControllerMC.RECORD , onControllerMCHandler);
			_controller.removeEventListener( ControllerMC.STOP , onControllerMCHandler);
			_controller.removeEventListener( ControllerMC.PLAY , onControllerMCHandler);
			_controller.removeEventListener( ControllerMC.SAVE , onControllerMCHandler);
		
		}
		
	}	
}


