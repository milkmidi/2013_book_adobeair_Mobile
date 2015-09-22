package com.milkmidi.gesture
{
	import flash.display.Sprite;
	import flash.events.TouchEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import milkmidi.display.MSprite;
	import milkmidi.utils.DeviceUtil;
	import milkmidi.utils.TextFieldUtil;

	[SWF(width = 480, height = 800, frameRate = 30, backgroundColor = 0xffffff)]			
	public class MultitouchExample extends MSprite 	{
		// 記錄多點觸控物件的資訊
		private var _dots		:Object = { };
		// 記錄多點觸控物件的文字
		private var _labels		:Object = { };		
		// 目前已觸控的點數
		private var _dotCount	:uint = 0;
		// 測試用的文字
		private var _debugTF	:TextField;
		
		public function MultitouchExample()		{
			
		}
		override protected function atAddedToStage():void {
			super.atAddedToStage();
			stage.align = "tl";
			stage.scaleMode = "noScale";
			
			// 指定 inputMode 為多點觸控
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			//TextFieldUtil.create( this, "多點觸控", 5, 5, 12 * DeviceUtil.dpiScale );			
			
			_debugTF = getLabel("");			
			_debugTF.x = 2;
			_debugTF.y = DeviceUtil.actionBarHeight;
			_debugTF.text = " Multitouch.maxTouchPoints:" + Multitouch.maxTouchPoints;			
			addChild(_debugTF);		

			// 偵聽觸控事件按下
			
			stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBeginHandler);
			// 偵聽觸控事件移動
			stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMoveHandler);
			// 偵聽觸控事件結束
			stage.addEventListener(TouchEvent.TOUCH_END, onTouchEndHandler);
		}
		
		

		private function onTouchBeginHandler(e:TouchEvent):void {
			// 如果目前己觸控的點數等於裝置支援的觸控點數
			if (_dotCount == Multitouch.maxTouchPoints) 
				return;
			// 建立圓點物件
			var dot:Sprite = getCircle();			
			dot.x = e.stageX;
			dot.y = e.stageY;
			addChild(dot);
			// 開始托拉
			dot.startTouchDrag(e.touchPointID, true);			
			// 將圓點物件暫存下來
			_dots[e.touchPointID] = dot;
			
			// 己觸控的點數加 1
			++_dotCount;

			// 建立文字資料
			var label:TextField = getLabel( e.touchPointID + ":" + e.stageX + ", " + e.stageY);			
			label.x = 3;
			label.y = _dotCount * 50;
			addChild(label);
			_labels[e.touchPointID] = label;
		}
		
		private function onTouchMoveHandler(e:TouchEvent):void 		{	
			// 得到對應的文字物件
			var label:TextField = _labels[e.touchPointID];
			label.text = (e.touchPointID + ":" + e.stageX + ", " + e.stageY);		
			
			// 如果觸控的點等於 2 時, 就畫一個圖型的框
			if (_dotCount == 2) {	
				graphics.clear();				
				// 起始 x 軸
				var centerX:int = (_dots[0].x + _dots[1].x) / 2;
				// 起始 y 軸
				var centerY:int = (_dots[0].y + _dots[1].y) / 2;
				// 求半徑, 用畢式定理求二點之間的距離
				// 或是用 Point.distance 的方法計算也可以
				var radius	:Number = Point.distance( 
					new Point( _dots[0].x , _dots[0].y ) ,
					new Point( _dots[1].x , _dots[1].y ) 
					) / 2;				
				graphics.lineStyle( 2 , 0x000000 );
				graphics.drawCircle(centerX, centerY, radius);				
				graphics.endFill();
			}
		}
		
		private function onTouchEndHandler(e:TouchEvent):void {
			// 得到對應的圓點物件和文字
			var dot:Sprite = _dots[e.touchPointID];			
			var label:TextField = _labels[e.touchPointID];
			
			// 從場景上移除
			removeChild(dot);
			removeChild(label);
			
			// 刪除 Object 裡的值, 避免還有物件暫存
			delete _dots[e.touchPointID];
			delete _labels[e.touchPointID];
			
			--_dotCount;
			
			graphics.clear();
		}
		
		// 建立圓點物件
		private function getCircle():Sprite		{
			var circle:Sprite = new Sprite();
			circle.graphics.beginFill(0x000000);
			circle.graphics.drawCircle(0, 0, 50);
			circle.graphics.endFill();
			circle.cacheAsBitmap = true;
			circle.cacheAsBitmapMatrix = new Matrix;
			return circle;
		}

		
		// 建立文字物件		 
		private function getLabel( pText:String):TextField 		{
			var tf:TextFormat = new TextFormat();
			tf.color = 0x000000;
			tf.size = 12 * DeviceUtil.dpiScale;
			var label:TextField = new TextField();
			label.width = 480;
			label.defaultTextFormat = tf;
			label.selectable = false;
			label.text = pText;
			return label;
		}
		override protected function atRemovedFromStage():void {
			super.atRemovedFromStage();
			stage.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBeginHandler);
			// 偵聽觸控事件移動
			stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMoveHandler);
			// 偵聽觸控事件結束
			stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEndHandler);
		}
	}
}
