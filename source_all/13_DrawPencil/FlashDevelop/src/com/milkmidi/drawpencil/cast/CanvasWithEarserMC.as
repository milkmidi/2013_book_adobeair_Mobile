/**
 * @author milkmidi
 * @date created 2012/07/28/
 */
package com.milkmidi.drawpencil.cast {		
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class CanvasWithEarserMC extends CanvasMC {		
		// 橡皮擦的大小
		private static const EARSE_SIZE	:int = 40;
		// 橡皮擦大小的一半
		private static const HALF_SIZE	:int = 20;		
		// 目前的工具是繪圖還是橡皮擦
		public var tool			:String = "Draw";		
		// 畫上透明區塊用的 BitmapData
		private var _erasebmp	:BitmapData;		
		// 記錄座標
		private var _offset		:Point;
		// 要繪製的區塊
		private var _drawRect	:Rectangle;
		//__________________________________________________________________________________ Constructor
		public function CanvasWithEarserMC()  {					
			_offset = new Point();
			_drawRect = new Rectangle();			
			// 建立只有圓型的透明色塊
			_erasebmp = createEarseBitmap();
		}	
	
		private function createEarseBitmap():BitmapData {
			var circle:Sprite = new Sprite;
			circle.graphics.beginFill(0);
			circle.graphics.drawCircle(20, 20, 20);
			circle.graphics.endFill();	
			
			var bmd:BitmapData = new BitmapData(EARSE_SIZE, EARSE_SIZE, true, 0);
			// 填上白色
			bmd.fillRect(bmd.rect, 0xFFFFFFFF);	
			// 繪製圓型物件
			bmd.draw( circle );
			// 複製透明色塊			
			bmd.copyChannel(bmd, bmd.rect, new Point(), 1, BitmapDataChannel.ALPHA);					
			return bmd;
		}
		
		override protected function onStageEvent(e:MouseEvent):void {
			// 如果是繪圖, 就用本來的 CanvasMC 
			if (tool == "Draw") {
				super.onStageEvent(e);
				return;
			}			
			switch (e.type) {
				case MouseEvent.MOUSE_DOWN:
					_isMouseDown = true;							
					break;
				case MouseEvent.MOUSE_MOVE:
					if (!_isMouseDown) {
						return;			
					}			
					// 指定座標
					_offset.setTo( mouseX - HALF_SIZE, mouseY - HALF_SIZE );					
					// 指定區塊
					_drawRect.setTo(_offset.x, _offset.y, EARSE_SIZE, EARSE_SIZE);			
					// 貼上透明區塊
					_bitmap.bitmapData.copyPixels(_bitmap.bitmapData, _drawRect, _offset, _erasebmp, new Point(), false);																	
					break;
				case MouseEvent.MOUSE_UP:
					_isMouseDown = false;		
					
					break;
			}
		}
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package