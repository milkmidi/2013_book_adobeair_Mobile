/**
 * @author milkmidi
 */
package com.milkmidi.drawpencil.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event(name = "colorChange", type = "com.milkmidi.drawpencil.model.PencilEvent")]	
	[Event(name = "colorPickerShow", type = "com.milkmidi.drawpencil.model.PencilEvent")]	
	[Event(name = "colorPickerHide", type = "com.milkmidi.drawpencil.model.PencilEvent")]
	
	// 使用 Singleton 單一設計模式
	public class PencilModel extends EventDispatcher {
		
		
		private static var _instance:PencilModel;
		
		private var _color:uint = 0x000;		
		public function get color():uint {	return _color;		}		
		public function set color( value:uint ):void {
			this._color = value;
			// 當色彩改變時, 就發送 PencilEvent.COLOR_CHANGE 事件
			this.dispatchEvent( new PencilEvent( PencilEvent.COLOR_CHANGE ) );
		}
		
		public function PencilModel( pSingletonEnforcer:SingletonEnforcer ) {
			if ( pSingletonEnforcer == null ) {
				throw new Error( "PencilModel is obviously also... Singleton." );
			}
		}
	
		// 得到單一物件
		public static function getInstance():PencilModel {
			if ( _instance == null ) {
				_instance = new PencilModel( new SingletonEnforcer );
			}
			return _instance;
		}
		
		public function destroy():void {
			_instance = null;
			
		}
	
	}
}

internal class SingletonEnforcer {
}