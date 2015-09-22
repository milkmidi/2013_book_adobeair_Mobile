/**
 * @author milkmidi
 */
package com.milkmidi.shake {		
	import com.milkmidi.shake.events.ShakeEvent;
	import flash.events.AccelerometerEvent;
	import flash.events.EventDispatcher;
	import flash.sensors.Accelerometer;
	
	[Event(name = "change", type = "com.milkmidi.shake.events.ShakeEvent")]
	[Event(name = "shake", type = "com.milkmidi.shake.events.ShakeEvent")]	
	public class ShakeDetecter extends EventDispatcher {	
		// 搖晃變數, 數值越高, 判斷度也越高
		public static var THRESHOLD:Number = 1;
		
		// Accelermeter 物件, 計算三軸加速度
		private var _acc   :Accelerometer;
		
		// 記錄三軸上次更新的數值
		private var _prevX :Number = 0;
		private var _prevY :Number = 0;
		private var _prevZ :Number = 0;
		
		// 記錄已搖晃的次數
		private var _shakeCount	:int = 0;
		// 宣告成唯讀屬性
		public function get shakeCount():int {	return _shakeCount;		}
		
		// 是否啟用
		private var _enabled:Boolean = true;		
		public function get enabled():Boolean {		return _enabled;		}		
		public function set enabled(value:Boolean):void {			
			_enabled = value;								
		}
		
		//__________________________________________________________________________________ Constructor
		public function ShakeDetecter( pUpdateInterval:int = 80 )  {			
			// 判斷是否支援加速器
			if (Accelerometer.isSupported) {								
				// 建立 Accelermeter 物件
				_acc = new Accelerometer();
				// 更新時間的間隔
				_acc.setRequestedUpdateInterval(pUpdateInterval);
				// 偵聽更新事件
				_acc.addEventListener(AccelerometerEvent.UPDATE, onAccUpdatedHandler);
			}
		}				
		
		// 重新計算搖晃的次數
		public function reset():void {
			_shakeCount = 0;
		}
		
		private function onAccUpdatedHandler(e:AccelerometerEvent):void {
			// 如果未啟用, 就中斷後方的程式
			if (!_enabled) {
				return;
			}
			// 判斷三軸的變動數值			
			var changeX:Number = _prevX - e.accelerationX;
			var changeY:Number = _prevY - e.accelerationY;
			var changeZ:Number = _prevZ - e.accelerationZ;
					
			_prevX = e.accelerationX;
			_prevY = e.accelerationY;
			_prevZ = e.accelerationZ;
			
			// 記錄三軸變化的數值
			var change:Vector.<Number> = new <Number>[ changeX , changeY , changeZ ];
			// 發送事件
			dispatchEvent(new ShakeEvent(ShakeEvent.CHANGE , change ));
			
			// 如果三軸的變動數值其中有大於設定的搖晃數次的話					
			if ( Math.abs(changeX) > THRESHOLD 
				|| Math.abs(changeY) > THRESHOLD 
				|| Math.abs(changeZ) > THRESHOLD) {	
					
				
				// 發送事件
				_shakeCount++;
				dispatchEvent(new ShakeEvent(ShakeEvent.SHAKE ));
			}
			
		}
		
		public function destroy():void {
			try {
				_acc.removeEventListener(AccelerometerEvent.UPDATE, onAccUpdatedHandler);
				_acc = null;
				
			}catch (err:Error){
			
			}
		}
		
		
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package