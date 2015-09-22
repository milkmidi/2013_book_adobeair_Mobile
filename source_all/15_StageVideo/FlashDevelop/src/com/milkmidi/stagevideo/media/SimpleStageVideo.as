package com.milkmidi.stagevideo.media {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.media.*;
	import flash.net.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import milkmidi.display.MSprite;
	import milkmidi.events.StreamEvent;
	import milkmidi.qnx.display.Toast;
	import milkmidi.utils.ResizeUtil;
	/**
	 * ...
	 * @author milkmidi
	 */
	
	public class SimpleStageVideo extends MSprite {
		// 播放器狀態改變時
		public static const STATUS_CHANGE	:String = "statusChange";
		// 影片播放
		public static const PLAYING			:String = "playing";
		// 影片暫停
		public static const PAUSED			:String = "paused";
		// 影片播放完畢停止
		public static const STOPPED			:String = "stopped";		

		
		// 影片總播放時間, 單位秒		
		private var _videoDuration		:Number = 0;
		
		// Video 物件, 當不支援 StageVideo 時, 就改用 Video 播放
		private var _video				:Video;		
		// NetConnection 物件
		private var _nc					:NetConnection;		
		// NetStream 物件
		private var _ns					:NetStream;					
		// StageVideo 物件
		private var _stageVideo			:StageVideo;		
		// 目前播放的影片連結
		private var _url			:String;	
		// 影片原始寬度
		private var _metaDataWidth	:int;		
		// 影片原始高度
		private var _metaDataHeight	:int;		
		// 顯示的寬度
		private var _displayWidth:int = 320;		
		// 顯示的高度
		private var _displayHeight:int = 240;
		// 目前的播放狀態
		private var _status				:String;					
		public function get status():String { return _status; }		
		// 當播放狀態有更新時, 就發送事件
		public function set status(pStatus:String):void {
			if (_status != pStatus) {
				_status = pStatus;	
				log( "status:" + _status);				
				dispatchEvent(new Event(STATUS_CHANGE));					
			}				
		}			

		// 要載入的影片路徑
		public function SimpleStageVideo( pUrl:String  ) {				
			this._url = pUrl;					
		}			
		override protected function atAddedToStage():void {			
			_nc = new NetConnection();
			_nc.connect(null);
			_nc.addEventListener(NetStatusEvent.NET_STATUS , onNetStatusHandler );
			_ns = new NetStream( _nc );
			_ns.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusHandler);
			_ns.client = {
				onMetaData:onMetaData
			};			
			stage.addEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, onStageVideoStateHandler);		
		}	
		private function onStageVideoStateHandler(e:StageVideoAvailabilityEvent):void {
			stage.removeEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, onStageVideoStateHandler);			
			var available:Boolean = e.availability == StageVideoAvailability.AVAILABLE;
			
			//toggleStageVideo( available  );		
			toggleStageVideo( false  );		
			_ns.play(_url);				
		}			
		private function toggleStageVideo( on:Boolean):void {			
			log( "toggleStageVideo stageVideo:" + on + " stage.stageVideos.length:" + stage.stageVideos.length);
			
			if ( on ) {
				//Toast.makeText( stage , "StageVideo Available" ).show();
				if ( _stageVideo == null ) {
					var index:int = Math.max(0 , stage.stageVideos.length - 1 );					
					_stageVideo = stage.stageVideos[ index ];
					_stageVideo.attachNetStream( _ns );					
				}
			}else {
				if (_video == null) {
					_video = new Video();
					addChildAt(_video, 0);					
				}				
				//Toast.makeText( stage , "!!! XD , StageVideo Unavailable" ).show();
				_video.attachNetStream( _ns );				
			}			
		}				
		
		/**
		 * 讀取到影片相關資訊時, 如影片長、高，播放時間等屬性
		 * @param	pMetadata
		 */
		private function onMetaData( pMetadata:Object ):void {
			_videoDuration = pMetadata.duration;			
			_metaDataWidth = pMetadata.width;
			_metaDataHeight = pMetadata.height;		
			log( "onMetaData {" );
			log( "_videoDuration:" + _videoDuration);
			log( "_metaDataWidth:" + _metaDataWidth);
			log( "_metaDataHeight:" + _metaDataHeight);			
			log( "onMetaData }" );
			invalidate();
		}	
		private function onNetStatusHandler( e:NetStatusEvent ) :void {
			log("netStatus: " + e.info.code);					
			switch(e.info.code) {
				case NetStatusInfoCode.NetStream_Play_Start:
					// 開始播放				
					this.status = PLAYING;
					break;			
				case NetStatusInfoCode.NetStream_Play_Stop: 
					// 播放完畢
					this.status = STOPPED;
					break;
				case NetStatusInfoCode.NetStream_Pause_Notify: 
					// 影片暫停
					this.status = PAUSED;					
					break;
				case NetStatusInfoCode.NetStream_Unpause_Notify: 
					// 影片暫停後, 重新播放							
					this.status = PLAYING;
					break;
			}			
		}	
		
		public function togglePause():void {
			// 如果已經是播放完畢
			// 就再重新播放一次
			if (this.status == STOPPED) {
				_ns.seek( 0 );
				_ns.resume()
			}else {
				// 切換播放狀態
				_ns.togglePause();							
			}
		}		
	
			
		public function getCurrentTimeCode():String {
			return timeConvertToDigi( _ns.time );
		}
		public function getTotalTimeCode():String {
			return timeConvertToDigi( _videoDuration );
		}			
		private static function timeConvertToDigi(pTime:Number):String {
			var _tempNum:int = pTime;
			var _minutes:int = Math.floor(_tempNum / 60);					
			var _seconds:String = (_tempNum % 60)+"";			
			if (_seconds.length < 2)  { 				
				_seconds = "0" + _seconds;	
			}			
			return _minutes + ":" + _seconds;		
		}
		
		
		/**
		 * Resize 正確的大小
		 */
		private function invalidate ():void{				
			if (_metaDataWidth == 0 || _displayWidth == 0) {				
				return;
			}			
			var resizeRect:Rectangle = ResizeUtil.getResizeRect( 
				_metaDataWidth ,
				_metaDataHeight, 
				_displayWidth , 
				_displayHeight , 
				ResizeUtil.CENTER_INSIDE
			);					
			// 如果是使用 StageVideo 的話
			// 就把新的顯示範圍傳入
			if (_stageVideo) {
				_stageVideo.viewPort = resizeRect;	
				
			}else if ( _video) {
				// 如果是使用一般的 Video 的話
				// 更新座標與長、寬
				_video.x = resizeRect.x;
				_video.y = resizeRect.y;
				_video.width = resizeRect.width;
				_video.height = resizeRect.height;
			}			
			log(resizeRect + "");			
		}
		
		/**
		 * 更定顯示大小
		 * @param	w 要顯示的寬度
		 * @param	h 要顯示的高度
		 */
		public function setSize( w:int , h:int):void {
			if (this._displayWidth == w && this._displayHeight == h) {
				return;
			}
			log( "setSize", w, h);			
			this._displayWidth = w;
			this._displayHeight = h;
			invalidate();
		}
		
		
		/**
		 * 當被從場景上移除時, 就摧毀其他物件, 以利垃圾回收器回收不用的類別
		 */
		override protected function atRemovedFromStage():void {			
			_nc.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatusHandler);
			_nc.close();
			_nc = null;
			
			_ns.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatusHandler);
			_ns.close();
			_ns = null;			
			
			if (_stageVideo) {
				_stageVideo.attachNetStream( null );
				_stageVideo = null;	
			}
			_video = null;
			
		}
		private function log(...obj):void {
			trace.apply( null , ["[SimpleStageVideo]"].concat( obj ));			
		}
	}

}