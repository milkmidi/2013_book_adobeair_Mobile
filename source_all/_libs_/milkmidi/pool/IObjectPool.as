/**
 * @author milkmidi
 * @see http://milkmidi.blogspot.com
 */
package milkmidi.pool {
	import milkmidi.core.IDestroy;

	public interface IObjectPool extends IDestroy {	
		
		// 被 Pool 初始化
		function onPoolInit(...params:Array):void;		
		
		// 回收再利用
		function recycle():void;
	}	
}