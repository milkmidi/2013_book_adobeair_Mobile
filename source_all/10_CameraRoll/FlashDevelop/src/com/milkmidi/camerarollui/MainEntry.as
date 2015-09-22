
package com.milkmidi.camerarollui {		
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MediaEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.media.CameraRoll;
	import flash.media.CameraUI;
	import flash.media.MediaPromise;
	import flash.media.MediaType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import milkmidi.display.MApplication;
	import milkmidi.qnx.display.Toast;
	import milkmidi.utils.DeviceUtil;
	import milkmidi.utils.ResizeUtil;
	import milkmidi.utils.SimpleButtonProxy;
	
	[Embed(source="../../../../fla/assets.swf", symbol="swc.Main_mc")]
	public class MainEntry extends MApplication {		
		
		// 輸出文字
		private var _tf	:TextField;
		
		// 載入圖片用的 Loader
		private var _ldr:Loader;
		
		// 場景上的 album 按鈕
		public var album_mc:MovieClip;
		
		// 場景上的 camera 按鈕
		public var camera_mc:MovieClip;
		
		// 場景上的背景
		public var bg_mc	:MovieClip;		
		
		// 場景上的 save 按鈕
		public var save_mc	:MovieClip;
		public function MainEntry()  {			
		}		
		override protected function atAddedToStage():void {
			super.atAddedToStage();
			
			CONFIG::debug {
				DeviceUtil.devicesScale = 0.5;
			}
			
			// 建立簡易按鈕類別, 並同時加入 CLICK 偵聽
			new SimpleButtonProxy( album_mc ).addClick( cameraRollClickHandler);
			album_mc.scaleX = DeviceUtil.devicesScale;
			album_mc.scaleY = DeviceUtil.devicesScale;
			new SimpleButtonProxy( camera_mc ).addClick( cameraUIClickHandler);
			camera_mc.scaleX = DeviceUtil.devicesScale;
			camera_mc.scaleY = DeviceUtil.devicesScale;
			new SimpleButtonProxy( save_mc ).addClick( saveImageUIClickHandler);
			save_mc.scaleX = DeviceUtil.devicesScale;
			save_mc.scaleY = DeviceUtil.devicesScale;
			// 顯示用的文字
			_tf = new TextField;			
			_tf.width = stage.fullScreenWidth;
			
			var tf:TextFormat = new TextFormat(null, 14 * DeviceUtil.dpiScale);
			tf.align = TextFormatAlign.CENTER;			
			_tf.defaultTextFormat = tf;
			_tf.y = DeviceUtil.actionBarHeight;
			
			_tf.text = "CameraRoll Camera UI Example";
			addChild( _tf );					
	
			// 將載入圖片用的 Loader 加入到最底層
			addChildAt( _ldr = new Loader, 1);									
			_ldr.y = DeviceUtil.actionBarHeight;
			_ldr.contentLoaderInfo.addEventListener(Event.COMPLETE , onLoaderComplete );			
		}
		
		private function cameraRollClickHandler(e:MouseEvent):void {
			Toast.makeText( stage , "CameraRoll.supportsBrowseForImage:" + CameraRoll.supportsBrowseForImage ).show();			
			// 如果支援開啟圖片對話框的話
			if (CameraRoll.supportsBrowseForImage) {
				// 建立 CameraRoll 物件
				var _cameraRoll:CameraRoll = new CameraRoll();				
				// 偵聽當使用者選取圖片時
				_cameraRoll.addEventListener(MediaEvent.SELECT, onCameraRollMediaSelect);	
				_cameraRoll.addEventListener( ErrorEvent.ERROR, onMediaErrorHandler );
				// 開啟對話框
				_cameraRoll.browseForImage();
			}
		}
		
		private function onMediaErrorHandler(e:ErrorEvent):void {
			Toast.makeText( stage , e.toString() ).show();			
		}
		
		private function cameraUIClickHandler(e:MouseEvent):void {
			Toast.makeText( stage , "CameraUI.isSupported:" + CameraUI.isSupported ).show();			
			// 判斷裝置是否支援
			if (CameraUI.isSupported) {					
				// 建立 CameraUI 物件
				var _cameraUI:CameraUI = new CameraUI();
				// 偵聽擷取完成事件
				_cameraUI.addEventListener(MediaEvent.COMPLETE, onCameraRollMediaSelect);
				// 啟動擷取圖片
				_cameraUI.launch(MediaType.IMAGE);				
			}
		}		
		
		private function saveImageUIClickHandler(e:MouseEvent):void {
			// 建立 CameraRoll
			var roll:CameraRoll = new CameraRoll();
			roll.addEventListener(Event.COMPLETE , function ():void {
				Toast.makeText( stage , "Save Success").show();
			});
			var bmp:BitmapData = new BitmapData( stage.stageWidth, stage.stageHeight, false);
			bmp.draw( this );
			roll.addBitmapData( bmp );
			bmp.dispose();
		}
		
		// 當使用者選取圖片
		private function onCameraRollMediaSelect(e:MediaEvent):void {			
			// 載入圖片
			var imagePromise:MediaPromise = e.data;			
			_ldr.loadFilePromise( imagePromise );				
		}

		
		private function onLoaderComplete(e:Event):void {
			Toast.makeText( stage , "onLoaderComplete" ).show();		
			// 顯示原始圖片大小
			_tf.text = _ldr.width + "x" + _ldr.height;
			// 開啟平滑化
			Bitmap(_ldr.content).smoothing = true;
			// 圖片置中 resize 工具
			ResizeUtil.resize( _ldr , stage );	
		}
		override protected function atResize():void {
			var pY:int = stage.stageHeight - DeviceUtil.actionBarHeight - album_mc.height;		
			album_mc.x = 90;
			album_mc.y = pY;
			camera_mc.x = stage.stageWidth >> 1;
			camera_mc.y = pY;
			save_mc.x = stage.stageWidth - 90;
			save_mc.y = pY;
			bg_mc.width = stage.fullScreenWidth;
			bg_mc.height = stage.fullScreenHeight;
		}
		
		
	}
}