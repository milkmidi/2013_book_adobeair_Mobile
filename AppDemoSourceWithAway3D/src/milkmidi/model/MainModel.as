/**
 * @author milkmidi
 * @date created 2012/11/04/
 */
package milkmidi.model {	
	import flash.events.*;
	import flash.net.LocalConnection;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	
	public class MainModel  {		
		private static var _instance:MainModel;
		
		private var _onChangeView:ISignal;
		public function get onChangeView():ISignal/*int*/ {		return _onChangeView;		}
		
		private var _currentIndex:int = -2;
		public function get currentIndex():int {		return _currentIndex;		}		
		public function set currentIndex(value:int):void {
			if (value == _currentIndex) {
				return;
			}
			_currentIndex = value;
			
			try {
				new LocalConnection().connect("foo");
				new LocalConnection().connect("foo");
			}catch (err:Error) {				
			
			}
			
			onChangeView.dispatch( _currentIndex );
		}
		
		public function MainModel(pSingletonEnforcer:SingletonEnforcer) {
			if (pSingletonEnforcer == null) 
				throw new Error("MainModel is obviously also... Singleton.");			
			_onChangeView = new Signal(int);
		}		
		public static function get instance():MainModel {			
			return MainModel._instance ||= new MainModel(new SingletonEnforcer());				
		}		
		
		
		
	
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package
	
internal class SingletonEnforcer {}