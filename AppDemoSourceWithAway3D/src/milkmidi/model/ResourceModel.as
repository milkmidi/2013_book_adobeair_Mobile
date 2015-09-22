/**
 * @author milkmidi
 * @date created 2012/12/30/
 */
package milkmidi.model {		
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	public class ResourceModel {		
		[Embed(source = "../../../../source_all/01_HelloAdobeAIR/FlashDevelop/bin/application.swf")]		
		private static const A0:Class;				
		[Embed(source = "../../../../source_all/03_CatJumper/FlashDevelop/bin/application.swf")]
		private static const A1:Class;		
		[Embed(source="../../../../source_all/04_Embed_SWC/01_Embed_SWC/bin/application.swf")]
		private static const A2:Class;		
		[Embed(source = "../../../../source_all/05_qnx_ui_component/bin/quxUIComponent.swf")]				
		private static const A3:Class;			
		[Embed(source = "../../../../source_all/06_CatchAsBitmapMatrix/FlashDevelop/bin/catchAsBitmapMatrixDemo.swf")]						
		private static const A4:Class;		
		[Embed(source = "../../../../source_all/07_Gesture/FlashDevelop/bin/GestureExample.swf")]		
		private static const A5:Class;		
		[Embed(source="../../../../source_all/07_Gesture/FlashDevelop/bin/MultitouchExample.swf")]
		private static const A6:Class;		
		[Embed(source = "../../../../source_all/08_Geolocation/FlashDevelop/bin/application.swf")]
		private static const A7:Class;		
		[Embed(source = "../../../../source_all/08_Geolocation/FlashDevelop/bin/StageWebView.swf")]
		private static const A8:Class;		
		[Embed(source = "../../../../source_all/09_Shake/FlashDevelop/bin/application.swf")]
		private static const A9:Class;		
		[Embed(source = "../../../../source_all/10_CameraRoll/FlashDevelop/bin/application.swf")]
		private static const A10:Class;		
		[Embed(source = "../../../../source_all/11_ConditionalCompilation/FlashDevelop/bin/application.swf")]
		private static const A11:Class;
		
		[Embed(source = "../../../../source_all/13_DrawPencil/FlashDevelop/bin/drawPencil.swf")]
		private static const A12:Class;
		[Embed(source = "../../../../source_all/14_MicRecorder/FlashDevelop/bin/application.swf")]
		private static const A13:Class;
		[Embed(source = "../../../../source_all/15_StageVideo/FlashDevelop/bin/application.swf")]
		private static const A14:Class;				
		[Embed(source = "../../../../source_all/12_Singleton/FlashCS6/bin/application.swf")]
		private static const A15:Class;
		
		
		[Embed(source = "../../assets/images/0.png")] private static const TEXTURE0:Class;		
		[Embed(source = "../../assets/images/1.png")] private static const TEXTURE1:Class;		
		[Embed(source = "../../assets/images/2.png")] private static const TEXTURE2:Class;		
		[Embed(source = "../../assets/images/3.png")] private static const TEXTURE3:Class;		
		[Embed(source = "../../assets/images/4.png")] private static const TEXTURE4:Class;		
		[Embed(source = "../../assets/images/5.png")] private static const TEXTURE5:Class;		
		[Embed(source = "../../assets/images/6.png")] private static const TEXTURE6:Class;		
		[Embed(source = "../../assets/images/7.png")] private static const TEXTURE7:Class;		
		[Embed(source = "../../assets/images/8.png")] private static const TEXTURE8:Class;		
		[Embed(source = "../../assets/images/9.png")] private static const TEXTURE9:Class;		
		[Embed(source = "../../assets/images/10.png")]private static const TEXTURE10:Class;		
		[Embed(source = "../../assets/images/11.png")]private static const TEXTURE11:Class;		
		[Embed(source = "../../assets/images/12.png")]private static const TEXTURE12:Class;		
		[Embed(source = "../../assets/images/13.png")]private static const TEXTURE13:Class;		
		[Embed(source = "../../assets/images/14.png")]private static const TEXTURE14:Class;		
		[Embed(source = "../../assets/images/15.png")]private static const TEXTURE15:Class;		
			
		
	
	
		private static const DESCRIPTION:Vector.<String> = new <String>[
			"01 Hello Adobe AIR 製作第一個 Adobe App",
			"Accelerometer Game",
			"Embed & SWC",
			"QNX UI Component",
			"CatchAsBitmap",
			"Gestures",
			"MultiTouch",
			"Geolocation",
			"StageWebView",
			"Shake",
			"CameraUI",
			"ConditionalCompilation",
			"Draw Pencil",
			"Recorder",
			"StageVideo",
			"P2P",
			"Native Extensions",
			"About Me"
		];
		
		
		public static function get LENGTH():int {	return 18;		} 
		
		public static function getResource( index:int ):DisplayObject {		
			var cls:Class = ResourceModel["A" + index];			
			return new cls() as DisplayObject;
		}
		public static function getBitmapData( index:int ):BitmapData {
			var cls:Class = ResourceModel["TEXTURE" + index];
			return Bitmap( new cls ).bitmapData;
		}
		public static function getDescription( index:int ):String {
			return DESCRIPTION[index];
		}
		
	
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package