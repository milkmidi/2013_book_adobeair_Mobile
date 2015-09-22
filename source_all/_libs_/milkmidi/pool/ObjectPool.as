
package milkmidi.pool {		
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import milkmidi.core.milkmidi_ns;
	use namespace milkmidi_ns;
	public final class ObjectPool {		
		/**
		 * @private
		 */
		milkmidi_ns static var pools:Dictionary = new Dictionary();	
		
		/**
		 * @private
		 */
		milkmidi_ns static var debug:Boolean = false;
		
		/**
		 * @private
		 */
		private static var TAG:String = "ObjectPool";
		/**
		 * 
		 */
		public function ObjectPool()  {	
			
		}	
		
		/**
		 * 直接 new 物件, 放到 pool 裡
		 * @param	pClass
		 * @param	pLength
		 * @param	...pParams
		
		public static function create( pClass:Class , pLength:int , ...pParams:Array):void {			
			if (pClass in pools) {
				throw new Error("Pool 已經有東西了!, 錯");				
			}
			var pool:Vector.<IObjectPool> = getPool( pClass );
			var i:int = pLength;
			while(--i > -1){
				pool.push( construct( pClass, pParams ));
			}
		} */
		
		/**
		 * 從 pool 裡建立物件
		 * @param	pClass Class
		 * @param	...pParams constructor parameters
		 * @return Class instance
		 */
		public static function obtain( pClass:Class, ...pParams:Array ):* {
			var _pool	:Vector.<IObjectPool> = getPool( pClass );
			var _o		:IObjectPool;
			if ( _pool.length > 0 )	{
				_o = _pool.pop();
			}
			else {
				_o = construct( pClass, pParams );								
			}
			
			_o.onPoolInit.apply(_o, pParams);				
			return _o;
		}	
		/**
		 * recycler, 然後回收進 pool 裡
		 * @param	pObject 要回收的物件。
		 * @param	pClass 回收到那個 pool
		 */
		public static function recycle( pObject:IObjectPool, pClass:Class = null ):void {						
			if (pClass == null) {
				pClass = getDefinitionByName( getQualifiedClassName( pObject )) as Class;	
			}
			var _pool	:Vector.<IObjectPool> = getPool( pClass );
			if(debug)
				trace( TAG , " recycler() > object: " + pObject );					
			
				
			if (_pool.indexOf( pObject ) == -1) {
				_pool.push( pObject );							
			}
			
			
		}
		/**
		 * destroyPool
		 * @param	pClass 類別
		 * @param	pEveryFun every的function
		 */
		public static function destroyPool(pClass:Class, pEveryFun:Function = null):void {
			if (!(pClass in pools)) return;			
			if(debug)				
				trace( TAG , " destroyPool() > class: " + pClass );
			var _arr:Vector.<IObjectPool> = getPool(pClass);
			while ( _arr.length ) {
				_arr.pop().destroy();				
			}					
			if (pEveryFun != null)
				_arr.every( pEveryFun );
				
			_arr = null;
			pools[pClass] = null;			
			delete pools[pClass];			
		}
	
		
		/**
		 * @private
		 */
		milkmidi_ns static function getPool( pClass:Class ):Vector.<IObjectPool>{			
			return pClass in pools ? pools[pClass] : (pools[pClass] = new Vector.<IObjectPool>());			
		}			
		
		milkmidi_ns static function getPoolLength( pClass:Class ):int {			
			return pClass in pools ? getPool( pClass ).length : 0;
		}
	}	
}

function construct( pClass:Class, pParams:Array ):*{
	switch( pParams.length ) {
		case 0:	return new pClass();
		case 1:	return new pClass( pParams[0] );
		case 2:	return new pClass( pParams[0], pParams[1] );
		case 3:	return new pClass( pParams[0], pParams[1], pParams[2] );
		case 4:	return new pClass( pParams[0], pParams[1], pParams[2], pParams[3] );
		case 5:	return new pClass( pParams[0], pParams[1], pParams[2], pParams[3], pParams[4] );
		case 6:	return new pClass( pParams[0], pParams[1], pParams[2], pParams[3], pParams[4], pParams[5] );
		case 7:	return new pClass( pParams[0], pParams[1], pParams[2], pParams[3], pParams[4], pParams[5], pParams[6] );
		case 8:	return new pClass( pParams[0], pParams[1], pParams[2], pParams[3], pParams[4], pParams[5], pParams[6], pParams[7] );
		case 9:	return new pClass( pParams[0], pParams[1], pParams[2], pParams[3], pParams[4], pParams[5], pParams[6], pParams[7], pParams[8] );
		case 10:return new pClass( pParams[0], pParams[1], pParams[2], pParams[3], pParams[4], pParams[5], pParams[6], pParams[7], pParams[8], pParams[9] );
		default:
			return null;
	}
}