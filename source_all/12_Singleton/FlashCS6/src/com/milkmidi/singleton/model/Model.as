/**
 * @author milkmidi
 */
package com.milkmidi.singleton.model {
	import flash.events.EventDispatcher;
	
	public class Model extends EventDispatcher {
		public var myVar:String;
		
		// 類別的靜態屬性
		private static var _instance:Model;		
		public function Model( pSingletonEnforcer:SingletonEnforcer ) {
			if ( pSingletonEnforcer == null ) {
				throw new Error( "哇巫, Model 類別是 Singleton. 不可以建立二個喔!^()^" );
			}
		}		
		public static function getInstance():Model {
			// 如果 _instance 是空值			
			if ( _instance == null ) {
				// 建立物件
				_instance = new Model( new SingletonEnforcer );
			}
			return _instance;
		}
	}
}
// 在 package 外宣告一個 internal 的 class
internal class SingletonEnforcer {}