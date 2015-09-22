package  {		
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.sensors.Geolocation;
	import flash.system.Capabilities;
	import flash.text.*;	
	import flash.ui.Multitouch;
	import milkmidi.display.MSprite;
	import milkmidi.utils.DeviceUtil;
	// Flex SDK 使用的標籤, 當有指定時, 會忽略 Flash 上的設定。
	// width	：swf 檔的寬度
	// height	：swf 檔的高度
	// frameRate：FPS 影格速率
	// backgroundColor：舞台背景色	
	[SWF(width = "480", height = "800", frameRate = "30", backgroundColor = "#ffffff")]	
	// 只要是主程式, 都一定要是繼承 Sprite 或是 MovieClip。	
	public class Main extends MSprite {				
		// 舞台上已存在的文字物件, 用來顯示輸出的資訊
		public var my_txt:TextField;
		
		public function Main()  {			
						
		}		
		override protected function atAddedToStage():void {
			super.atAddedToStage();
			
			
			
			my_txt = new TextField;
			my_txt.defaultTextFormat = new TextFormat(null, DeviceUtil.dpiScale * 16);					
			addChild( my_txt );
			my_txt.x = 5;			
			my_txt.y = DeviceUtil.actionBarHeight;			
			
			// 文字自動縮放, 對齊左邊
			my_txt.autoSize = TextFieldAutoSize.LEFT;			
			my_txt.text = "Hello AIR";
		
			log("系統");			
			log("os = " + Capabilities.os);			
			//  AIR 執行階段的製造商。
			log("manufacturer = " + Capabilities.manufacturer);
			// 目前的 CPU 架構
			log("cpuArchitecture = " + Capabilities.cpuArchitecture);
			// 目前裝置使用的語系。
			log("language = " + Capabilities.language);
			// Flash Player 的版本號。
			log("Flash Player version = " + Capabilities.version);
			log("");
			
			// swf 檔目前的場景寬度。
			log("解析度");
			log("stage.stageWidth = " + stage.stageWidth + " x " + stage.stageHeight);											
			log("stage.fullScreenWidth = " + stage.fullScreenWidth + " x " + stage.fullScreenHeight);						
			// 目前裝置螢幕的最大水平解析度。
			log("Capabilities.screenResolutionX = " + Capabilities.screenResolutionX + " x " + Capabilities.screenResolutionY);												
			// 是否支援螢幕旋轉。
			log("supportsOrientationChange = " + Stage.supportsOrientationChange);
			// 是否支援自動螢幕旋轉。
			log("autoOrients = " + stage.autoOrients);
			// 目前的螢幕旋轉方向。
			log("orientation = " + stage.orientation);
			// 目前裝置的預設旋轉方向。
			log("deviceOrientation = " + stage.deviceOrientation);						
			// 目前裝置螢幕解析度的 dpi 值 , 注 2 。
			log("screenDPI = " + Capabilities.screenDPI);			
			log("");

			log("感應器支援");
			// 是否支援 Camera 。
			log("Camera.isSupported = " + Camera.isSupported);
			// 是否支援麥克風。
			log("Microphone.isSupported = " + Microphone.isSupported);
			// 是否支援地理位置感應器。
			log("Geolocation.isSuppored = " + Geolocation.isSupported);
			log("");			

			log("多點觸控");
			// 多點觸控模式
			log("Multitouch.inputMode = "+Multitouch.inputMode);
			// 多點觸控數量上限
			log("Multitouch.maxTouchPoints = "+Multitouch.maxTouchPoints);
			// 多點觸控類型
			log("Multitouch.supportedGestures = "+Multitouch.supportedGestures);
			log("");
			
			var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appXML.namespace();
			var versionNumber:String = appXML.ns::versionNumber;
			
			// application 說明文件裡, versionNumber 標籤
			log("描述檔裡的版本號 versionNumber = " + versionNumber);
			var versionLabel:String = appXML.ns::versionLabel;
			// application 說明文件裡, versionLabel 標籤
			log("描述檔裡的版本號標籤 versionLabel = " + versionLabel);	
		}
		private function log( val:* ):void {			
			my_txt.appendText( '\n' + val);
		}
	}
}
