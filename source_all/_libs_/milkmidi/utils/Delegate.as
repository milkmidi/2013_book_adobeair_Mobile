package milkmidi.utils {
	
	
	public final class Delegate {
		
		public static function create( handler:Function , ... args ):Function {
			
			return function( ... innerArgs ):* {
				return handler.apply( this , innerArgs.concat( args ) );
			}
		}	
	}
}
