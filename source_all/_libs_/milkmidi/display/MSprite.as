/**
 * @author milkmidi
 */
package milkmidi.display {		
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * 偵聽 addedToStage 與 removedFromStage
	 */
	public class MSprite extends Sprite {		
		
		public function MSprite()  {			
			super();
			if ( stage )
				onAddedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE , onAddedToStage);			
		}			
		private function onAddedToStage(e:Event = null):void {			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE , onRemovedFromStage);
			atAddedToStage();
			
			// 偵聽場景大小改變事件
			stage.addEventListener(Event.RESIZE , onResize);
			atResize();
		}
		private function onResize(e:Event):void {
			atResize();
		}			
		protected function atResize():void {	}
		
		// 當被加入到 stage 上時
		protected function atAddedToStage():void {		}

		private function onRemovedFromStage(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			stage.removeEventListener(Event.RESIZE , onResize);
			atRemovedFromStage();
		}		
		
		// 從 stage 上被移除時		
		protected function atRemovedFromStage():void {	}	
	}
}