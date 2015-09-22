/**
 * @author milkmidi
 * @date created 2012/04/18/
 */
package milkmidi.qnx.view {		
	import flash.display.DisplayObject;
	import milkmidi.qnx.viewnavigator.IViewNavigator;
	import milkmidi.qnx.viewnavigator.ViewNavigator;
	import qnx.ui.core.Container;
	import qnx.ui.core.UIComponent;
	
	public class View extends Container implements IView {		
		private var _navigator:IViewNavigator;
		
		private var _data:Object;
		public function get data():Object {	return _data;		}		
		public function set data(value:Object):void {
			_data = value;
		}
		//__________________________________________________________________________________ Constructor
		public function View( s:Number = 100 , su:String = "percent" )  {			
			super( s , su );
		}				
		/* INTERFACE milkmidi.qnx.view.IView */		
		public function toDisplayObject():DisplayObject {
			return this;
		}
		
		/* INTERFACE milkmidi.viewnavigator.IView */		
		public function get navigator():IViewNavigator {	return _navigator;		}		
		public function set navigator(value:IViewNavigator):void {
			_navigator = value;
		}
		
		public function get viewReturnObject():Object {
			return null;
		}
		
		
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package