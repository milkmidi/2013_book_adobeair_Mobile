
package com.milkmidi.drawpencil.cast {		
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import com.milkmidi.drawpencil.model.PencilEvent;
	import com.milkmidi.drawpencil.model.PencilModel;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import milkmidi.display.MSprite;
	
	[Embed(source="../../../../../fla/Pencil.swf", symbol="swc.Pencil_mc")]
	public class PencilMC extends MSprite {		
		// swc.Pencil_mc 裡的 pencil_mc 元件
		public var pencil_mc    :MovieClip;

		// 色碼, 預設是黑色
		private var _color		:uint = 0x0;
		public function get color():uint {		return _color;		}		
		public function set color(value:uint):void {
			_color = value;
			// 當被指定新的色碼時, 使用 ColorTransform
			// 讓 pencil_mc.color_mc 也同時變色
			var _colorTF:ColorTransform = new ColorTransform();
			_colorTF.color = _color;						
			pencil_mc.color_mc.transform.colorTransform = _colorTF;			
		}
		
		private var _lock:Boolean = false;
		
		public function PencilMC()  {	
			// 取消滑鼠感應功能
			mouseEnabled = false;
			mouseChildren = false;
			
			PencilModel.getInstance().addEventListener(PencilEvent.COLOR_PICKER_SHOW , onColorPickerState);
			PencilModel.getInstance().addEventListener(PencilEvent.COLOR_PICKER_HIDE , onColorPickerState);
		}	
		
		private function onColorPickerState(e:PencilEvent):void {
			if ( e.type == PencilEvent.COLOR_PICKER_SHOW ) {
				_lock = true;
				TweenMax.to( this , .5, {
					x			:stage.stageWidth * .25,					
					y			:stage.stageHeight >> 1,
					ease		:Cubic.easeInOut
				} );
			}else {
				_lock = false;
			}
		}
		override protected function atAddedToStage():void {			
			// 當初加入至場景上時, 偵聽事件
			stage.addEventListener(MouseEvent.MOUSE_DOWN , onStageEventListener);			
			stage.addEventListener(MouseEvent.MOUSE_UP , onStageEventListener);
			stage.addEventListener(MouseEvent.MOUSE_MOVE , onStageEventListener);			
		}
		
		private function onStageEventListener(e:MouseEvent):void {
			if ( _lock ) {
				return;
			}
			switch (e.type) {
				case MouseEvent.MOUSE_DOWN:
					// 當使用者點擊時
					isDown(true);
					break;
				case MouseEvent.MOUSE_MOVE:
					// 依畫筆元件的座標, 做簡單的旋轉效果
					var posMouseX:Number = e.stageX;
					var posMouseY:Number = e.stageY;
					var limitY:Number = 140;
					this.x = posMouseX;
					this.y = posMouseY;
					this.rotation -= (posMouseY < limitY) ? (rotation - ( limitY - posMouseY )) * .1 : (rotation - 0 ) * .1;	
					break;
				case MouseEvent.MOUSE_UP:
					// 放開時
					isDown(false);
					break;
			}
		}	
		private function isDown(pIsDown:Boolean):void {
			// 依使用者是否按下, 做簡單的物件位移, 
			// 好提醒使用者現在是否是按下狀態
			pencil_mc.y = pIsDown ? 10 : 0;
		}		
		
		override protected function atRemovedFromStage():void {
			super.atRemovedFromStage();
			stage.removeEventListener(MouseEvent.MOUSE_DOWN , onStageEventListener);			
			stage.removeEventListener(MouseEvent.MOUSE_UP , onStageEventListener);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE , onStageEventListener);
			PencilModel.getInstance().removeEventListener(PencilEvent.COLOR_PICKER_SHOW , onColorPickerState);
			PencilModel.getInstance().removeEventListener(PencilEvent.COLOR_PICKER_HIDE , onColorPickerState);
		}
		
	
	}	
}