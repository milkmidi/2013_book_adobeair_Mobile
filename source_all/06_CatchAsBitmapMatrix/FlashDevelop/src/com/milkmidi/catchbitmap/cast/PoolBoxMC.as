/**
 * @author milkmidi
 */
package com.milkmidi.catchbitmap.cast {		
	import swc.Box_mc;
	
	public class PoolBoxMC extends Box_mc{		
		public var percent:Number;
		public var tr:Number;
		public var ta:Number;
		public var sx:Number;
		public var sy:Number;
		
		
		// 宣告 Pool 用的陣列
		private static var POOL:Vector.<PoolBoxMC> = new Vector.<PoolBoxMC>();
		public function PoolBoxMC()  {			
			
		}		
		
		// 得到物件, 如空 Pool 裡有值, 就從 Pool 取出
		// Pool 是空的話, 才建立新的物件
		public static function obtain():PoolBoxMC {
			var mc:PoolBoxMC;
			if (POOL.length > 0) {
				mc = POOL.pop();
				mc.onPoolInit();
			}else {
				mc = new PoolBoxMC;
			}			
			return mc
		}
		
		// 每次物件被取出時, 用來重新設定屬性
		private function onPoolInit():void {
			this.cacheAsBitmap = false;
			this.cacheAsBitmapMatrix = null;
			this.x = 0;
			this.y = 0;
			this.scaleX = 1;
			this.scaleY = 1;
			this.rotation = 0;
			this.alpha = 1;
		}
		
		// 回收, 把物件放進 Pool裡
		public function recycle():void {
			if (POOL.indexOf( this ) == -1) {
				POOL.push( this );							
			}			
			parent.removeChild( this );
		}
		
		
		
	}
}