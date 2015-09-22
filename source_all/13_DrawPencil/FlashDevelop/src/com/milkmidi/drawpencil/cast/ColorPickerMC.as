/**
 * @author milkmidi
 */
package com.milkmidi.drawpencil.cast {		

	import com.greensock.easing.Cubic;
	import com.greensock.TweenLite;
	import com.milkmidi.drawpencil.model.PencilEvent;
	import com.milkmidi.drawpencil.model.PencilModel;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import milkmidi.display.MSprite;
	
	[Embed(source = "../../../../../fla/Pencil.swf", symbol = "swc.ColorPicker_mc")]		
	public class ColorPickerMC extends MSprite {		
		// 場景上的元件
		public var hitArea_mc			:MovieClip;
		public var picker_mc			:MovieClip;
		public var select_mc			:MovieClip;
		
		// 用來得到色碼的 BitmapData
		private var _pixelBmp			:BitmapData = new BitmapData(1, 1);		
		
		// 目前所選的色碼
		private var _color		:uint = 0;
		
		public function ColorPickerMC()  {						
			
			// 取消 select_mc 的滑鼠感應功能
			select_mc.mouseEnabled = false;
			select_mc.mouseChildren = false;
			select_mc.visible = false;	
			
			// 先讓此物件消失
			visible = false;
			
			this.hitArea_mc.addEventListener(MouseEvent.MOUSE_DOWN , onMouseDownHandler);
			this.hitArea_mc.addEventListener(MouseEvent.MOUSE_MOVE , onMouseMoveHandler);
			this.addEventListener(MouseEvent.MOUSE_UP , onMouseUpHandler);
			
			PencilModel.getInstance().addEventListener(PencilEvent.COLOR_PICKER_SHOW , onPickerStateHandler);
			PencilModel.getInstance().addEventListener(PencilEvent.COLOR_PICKER_HIDE , onPickerStateHandler);
		}		
		
		private function onPickerStateHandler(e:PencilEvent):void {
			if ( e.type == PencilEvent.COLOR_PICKER_SHOW) {
				this.visible = true;
				this.rotation = -90;				
				TweenLite.to( this , .7, 	{
					overwrite		:true,
					rotation		:0,
					ease			:Cubic.easeInOut
				} );			
			}else {				
				TweenLite.to( this , .3,{
					overwrite		:true,
					rotation		:90,
					ease			:Cubic.easeInOut,
					onComplete		:onHideTweenComplete
				} );				
			}
		}					
		private function onHideTweenComplete():void {
			// 退完成後, 讓此元件暫時消失
			visible = false;			
		}
		
		private function onMouseDownHandler(e:MouseEvent):void {		
			// 按下後, 才顯示 select_mc 元件
			select_mc.visible = true;
			onMouseMoveHandler(null);
		}		
		private function onMouseMoveHandler(e:MouseEvent):void { 			
			// 讓 select_mc 元件的座標等於目前滑鼠的座標
			select_mc.x = mouseX;	
			select_mc.y = mouseY;
			
			// 使用 Matrix 矩陣位移, 告訴 BitmapData 要繪圖的位置
			var matrix:Matrix = new Matrix();
			matrix.translate( -picker_mc.mouseX , -picker_mc.mouseY);				
			_pixelBmp.draw(picker_mc, matrix);		
			
			// 取得色碼
			_color = _pixelBmp.getPixel(0, 0);	
			
			
			PencilModel.getInstance().color = _color;
			
			var _colorTF:ColorTransform = new ColorTransform();
			_colorTF.color = _color;						
			select_mc.color_mc.transform.colorTransform = _colorTF;		
		}		
		private function onMouseUpHandler(e:MouseEvent):void {
			var event:PencilEvent = new PencilEvent(PencilEvent.COLOR_PICKER_HIDE);
			PencilModel.getInstance().dispatchEvent( event );			
		}		
		
		override protected function atResize():void {
			super.atResize();
			x = stage.stageWidth;
			y = stage.stageHeight >> 1;			
		}
		
		override protected function atRemovedFromStage():void {
			super.atRemovedFromStage();
			this.hitArea_mc.removeEventListener(MouseEvent.MOUSE_DOWN , onMouseDownHandler);
			this.hitArea_mc.removeEventListener(MouseEvent.MOUSE_MOVE , onMouseMoveHandler);
			this.removeEventListener(MouseEvent.MOUSE_UP , onMouseUpHandler);
			
			PencilModel.getInstance().removeEventListener(PencilEvent.COLOR_PICKER_SHOW , onPickerStateHandler);
			PencilModel.getInstance().removeEventListener(PencilEvent.COLOR_PICKER_HIDE , onPickerStateHandler);
			
			try {
				_pixelBmp.dispose();
				_pixelBmp = null;
			}catch (err:Error){
			
			}
		}
		
	}	
}