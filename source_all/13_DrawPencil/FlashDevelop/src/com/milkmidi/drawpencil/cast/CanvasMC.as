package com.milkmidi.drawpencil.cast {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import milkmidi.display.MSprite;
	import swc.BG_mc;
	
	// 畫布類別
	public class CanvasMC extends MSprite {
		// 目前是否按下
		protected var _isMouseDown:Boolean = false;		
		// 繪圖區
		private var _canvas		:Sprite;		
		// 顯示用的點陣圖
		protected var _bitmap	:Bitmap;		
		// 目前的色彩
		public var color		:int = 0x0;		
		// 底圖材質
		private var _bg			:DisplayObject;		
		public function CanvasMC() {
		}
		
		override protected function atAddedToStage():void {
			// 偵對 stage 的事件
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onStageEvent );
			stage.addEventListener( MouseEvent.MOUSE_UP, onStageEvent );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onStageEvent );
			
			// 顯示用的背景材質						
			addChild( _bg = new BG_mc );			
			// 建構顯示用的點陣圖
			addChild( _bitmap = new Bitmap );
			// 建構繪圖用的 Sprite
			addChild( _canvas = new Sprite );
		}
		
		// 清空繪圖區
		public function clear():void {
			_canvas.graphics.clear();			
			// 重新填上白色色塊
			_bitmap.bitmapData.fillRect( new Rectangle( 0, 0, stage.stageWidth, stage.stageHeight ), 0xffffff );
		}
		
		protected function onStageEvent( e:MouseEvent ):void {
			switch ( e.type ) {
				case MouseEvent.MOUSE_DOWN: 
					// 按下時, 依座標畫出線段
					_isMouseDown = true;
					// 畫筆粗細使用亂數來決定
					var _stroke:int = Math.random() * 9 + 2;
					// 繪圖
					_canvas.graphics.lineStyle( _stroke, color, .8 );
					_canvas.graphics.moveTo( mouseX, mouseY );
					break;
				case MouseEvent.MOUSE_MOVE: 
					if ( !_isMouseDown ) {
						return;
					}
					_canvas.graphics.lineTo( mouseX, mouseY );
					break;
				case MouseEvent.MOUSE_UP: 
					// 放開時, 使用 BitmapData draw 將目前的繪圖區畫成 BitmapData
					_isMouseDown = false;
					_bitmap.bitmapData.draw( _canvas );
					_canvas.graphics.clear();
					break;
			}
		
		}
		
		override protected function atRemovedFromStage():void {
			super.atRemovedFromStage();
			stage.removeEventListener( MouseEvent.MOUSE_DOWN, onStageEvent );
			stage.removeEventListener( MouseEvent.MOUSE_UP, onStageEvent );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onStageEvent );
			try {
				_bitmap.bitmapData.dispose();
				_bitmap = null;
			}catch (err:Error){
			
			}
		}
		
		
		override protected function atResize():void {
			super.atResize();
			_bitmap.bitmapData = new BitmapData( stage.stageWidth, stage.stageHeight, true, 0 );
			_bg.width = stage.stageWidth;
			_bg.height = stage.stageHeight;
		}
	}
}