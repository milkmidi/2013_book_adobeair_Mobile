/**
 * @author milkmidi
 * @date created 2012/12/29/
 */
package milkmidi.model {		
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	public class StageModel {		
		
		
		private static var _stage:Stage;
		static public function get stage():Stage {	return _stage;		}
		
		static public function get stageWidth():int {		return _stage.stageWidth;		}
		static public function get stageHeight():int {		return _stage.stageHeight;		}
		public static function init( pStage:Stage ):void {
			_stage = pStage;
		}
		
		
		
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package