/**
 * @author milkmidi
 */
package milkmidi.utils {		
	import flash.net.LocalConnection;
	import flash.system.System;
	public final class SystemUtil {
		
		
	
		public static function clearMemory():void {
			try {
				new LocalConnection().connect('milkmidi');
				new LocalConnection().connect('milkmidi');
			} catch (e:Error) { }
			System.gc();			
			trace("SystemUtil memory from cleared    :" + (System.totalMemory / 1024)  +" kb");			
		}
	}
}