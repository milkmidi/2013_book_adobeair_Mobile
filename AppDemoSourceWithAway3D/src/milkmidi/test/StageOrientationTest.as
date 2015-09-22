/**
 * @author milkmidi
 * @date created 2012/12/29/
 */
package milkmidi.test {		
	import flash.display.Sprite;
	import flash.display.StageAspectRatio;
	import flash.events.MouseEvent;
	import flash.events.StageOrientationEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class StageOrientationTest extends Sprite{		
		
		private var _tf:TextField;
		//__________________________________________________________________________________ Constructor
		public function StageOrientationTest()  {			
			stage.align = "tl";
			stage.scaleMode = "noScale";
			addChild( _tf = new TextField);
			_tf.defaultTextFormat = new TextFormat(null, 20 );			
			_tf.text = "hello";
			_tf.width = 300;
			
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE , onOrientationHandler);
			
			var btn1:Sprite = createButton();
			addChild( btn1 );
			btn1.x = 300;
			btn1.addEventListener(MouseEvent.CLICK , function ():void {
				stage.setAspectRatio( StageAspectRatio.LANDSCAPE );
			});
			var btn2:Sprite = createButton();
			btn2.x = 300;
			btn2.y = 300;
			addChild( btn2 );
			btn2.addEventListener(MouseEvent.CLICK , function ():void {
				stage.setAspectRatio( StageAspectRatio.ANY );
			});
		}	
		private function createButton():Sprite {
			var spr:Sprite = new Sprite;
			spr.graphics.beginFill( 0xff0000 );
			spr.graphics.drawCircle(0, 0, 100);
			spr.graphics.endFill();
			return spr;
		}
		
		private function onOrientationHandler(e:StageOrientationEvent):void {
			_tf.appendText( "\n"+ stage.deviceOrientation   );
		}
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package