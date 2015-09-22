/**
 * @author milkmidi
 * @see http://milkmidi.blogspot.com
 * @version 1.0.1
 * @date created 2011/03/01/
 */
package milkmidi.away3d.view {		
	import away3d.containers.View3D;
	import flash.display.Sprite;
	import flash.events.Event;
	public class BasicView extends View3D {		
		
		private var _isRender:Boolean = true;
		
		public function get isRender():Boolean {	return _isRender;		}		
		public function set isRender(value:Boolean):void {
			_isRender = value;
			if (_isRender) {
				addEventListener(Event.ENTER_FRAME , onRenderHandler);
			}else {
				removeEventListener(Event.ENTER_FRAME , onRenderHandler);
			}
		}
		
		public function BasicView()  {			
			super();
			addEventListener(Event.ADDED_TO_STAGE , onAddedToStageHandler);			
		}		
		
		private function onAddedToStageHandler(e:Event):void {			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			addEventListener(Event.ENTER_FRAME , onRenderHandler);
			init();			
		}
		
		protected function init():void{
			
		}
		
		private function onRenderHandler(e:Event):void {			
			this.render();
			extraRender();
		}
		
		protected function extraRender():void{
			
		}
		public function destroy():void {
			removeEventListener(Event.ENTER_FRAME , onRenderHandler);
		}
		
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package