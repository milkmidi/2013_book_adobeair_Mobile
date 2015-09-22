/**
 * @author milkmidi
 * @date created 2012/06/14/
 */
package milkmidi.qnx.viewnavigator {
	import milkmidi.qnx.view.IView;

	public interface IViewNavigator {
		function popView():void;
		function pushView( pView:IView ):void;
		function get length():int;
	}
	
}