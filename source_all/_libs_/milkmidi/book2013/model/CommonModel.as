/**
 * @author milkmidi
 * @date created 2013/01/05/
 */
package milkmidi.book2013.model {	
	
	import flash.events.*;
	import org.osflash.signals.ISignal;	
	import org.osflash.signals.Signal;
	
	public class CommonModel {
		private static var _instance:CommonModel;
		
		
		private var _onActionBarLabelChange:ISignal;
		public function get onActionBarLabelChange():ISignal {		return _onActionBarLabelChange;		}
		
		
		
		public function CommonModel( pSingletonEnforcer:SingletonEnforcer ) {
			if ( pSingletonEnforcer == null )
				throw new Error( "CommonModel is obviously also... Singleton." );
			_onActionBarLabelChange = new Signal( String );
			
		}
		
		public static function get instance():CommonModel {
			if ( _instance == null ) {
				_instance = new CommonModel( new SingletonEnforcer );
			}
			return _instance;
		}
		
		
		
	} //__________________________________________________________________________________ End Class
} //__________________________________________________________________________________ End Package


internal class SingletonEnforcer {}