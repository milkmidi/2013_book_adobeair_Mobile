/**
 * @author milkmidi
 * @date created 2012/08/28/
 */
package  {		
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class EventCaptureAndBubble extends Sprite{		
		
		//__________________________________________________________________________________ Constructor
		public function EventCaptureAndBubble()  {			
			
			
			
			
			for (var i:int = 0; i < 100; i++) {
				var ball:Ball = new Ball();
				ball.x = Math.random() * stage.stageWidth;
				ball.y = Math.random() * stage.stageHeight;
				ball.name = "ball" + i;
				addChild( ball );				
				//ball.addEventListener(MouseEvent.CLICK , onBallClickHandler);
			}			
			
			this.addEventListener(MouseEvent.CLICK , onContainerClickHandler );
		}	
		private function onBallClickHandler(e:MouseEvent):void {
			var ball:Ball = e.currentTarget as Ball;
			ball.removeEventListener(MouseEvent.CLICK , onBallClickHandler);
			trace( ball.name );
			removeChild( ball );
		}
		
		private function onContainerClickHandler(e:MouseEvent):void {
			e.stopPropagation();
			var ball:Ball = e.target as Ball;
			trace( ball.name );
			removeChild( ball );
		}
		
	
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package

import flash.display.Sprite;

class Ball extends Sprite {
	public function Ball() {
		super();
		this.buttonMode = true;
		this.graphics.beginFill( Math.random() * 0xffffff, 1);
		this.graphics.drawCircle( -20, -20, 20);
		this.graphics.endFill();
	}
	
}