/**
 * @author milkmidi
 */
package milkmidi.display {		
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import milkmidi.display.MSprite;
	import flash.display.Sprite;
	import milkmidi.utils.DeviceUtil;
	public class MApplication extends MSprite {		
		
		public function MApplication()  {			
			
		}		
		override protected function atAddedToStage():void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// 偵聽焦點為 swf 檔時
			stage.addEventListener(Event.ACTIVATE  , onActivateHandler);
			
			// 偵聽焦點離開 swf 檔時
			stage.addEventListener(Event.DEACTIVATE  , onActivateHandler);	
			
			DeviceUtil.init( stage );
		}
		private function onActivateHandler(e:Event):void {
			switch (e.type) {
				case Event.ACTIVATE:
					stage.frameRate = 30;
					break;
				case Event.DEACTIVATE:
					stage.frameRate = 0.0000001;
					break;
			}
		}
		override protected function atRemovedFromStage():void {
			stage.removeEventListener(Event.ACTIVATE  , onActivateHandler);
			stage.removeEventListener(Event.DEACTIVATE  , onActivateHandler);	
		}		
		
	
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package