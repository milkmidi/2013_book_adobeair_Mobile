/**
 * @author milkmidi
 * @date created 2012/04/18/
 */
package milkmidi.qnx.view {
	import flash.display.DisplayObject;
	import milkmidi.qnx.viewnavigator.IViewNavigator;
	import milkmidi.qnx.viewnavigator.ViewNavigator;
	import qnx.ui.display.ISizeable;
	
	public interface IView extends ISizeable{
		
		
		function get navigator():IViewNavigator;
		
		function set navigator( navigator:IViewNavigator ):void;
		
		function get viewReturnObject():Object;
		
		function toDisplayObject():DisplayObject;
	
	}
}