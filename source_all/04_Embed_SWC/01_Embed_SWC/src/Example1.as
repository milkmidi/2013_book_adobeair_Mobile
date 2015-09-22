package  {		
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import milkmidi.utils.DeviceUtil;
	
	
	[SWF(width = "480", height = "800", frameRate = "30", backgroundColor = "#ffffff")]
	public class Example1 extends Sprite {		
		
		[Embed(source = "assets/photo.png")]
		private static const PHOTO:Class;
		private var bitmap:Bitmap;
		public function Example1()  {					
			
			
			this.addEventListener(Event.ADDED_TO_STAGE , onAddedToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemvoedFromStageHandler);
		}		
		
	
		
		private function onAddedToStageHandler(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			
			var tf:TextField = new TextField();
			
			tf.defaultTextFormat = new TextFormat(null, 14 * DeviceUtil.dpiScale);			
			tf.text = " 將多個 swf 檔包裝成單一 swf 檔\n 支援 android 及 ios";
			tf.multiline = true;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.width = stage.stageWidth;
			tf.y = DeviceUtil.actionBarHeight;						
			addChild( tf );
			
			bitmap = addChild( new PHOTO ) as Bitmap;
			bitmap.smoothing = true;
			bitmap.y = tf.textHeight + 10 + DeviceUtil.actionBarHeight;			
			bitmap.width = stage.stageWidth;
			bitmap.scaleY = bitmap.scaleX;
			
		}
		private function onRemvoedFromStageHandler(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemvoedFromStageHandler);
			try {
				bitmap.bitmapData.dispose();				
			}catch (err:Error){
			
			}
			bitmap = null;
			
		}
	}	
}