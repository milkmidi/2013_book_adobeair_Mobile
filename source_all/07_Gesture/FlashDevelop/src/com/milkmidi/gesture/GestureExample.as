package com.milkmidi.gesture
{
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.PressAndTapGestureEvent;
	import flash.events.StageOrientationEvent;
	import flash.events.TransformGestureEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import milkmidi.display.MSprite;
	import milkmidi.utils.DeviceUtil;
	
	[SWF(width = 480, height = 800, frameRate = 30, backgroundColor = 0xffffff)]		
	public class GestureExample extends MSprite	{		
		[Embed(source = "assets/01.jpg")] private const EmbedJPG0:Class;		
		[Embed(source = "assets/02.jpg")] private const EmbedJPG1:Class;						
		[Embed(source = "assets/03.jpg")] private const EmbedJPG2:Class;						
		[Embed(source = "assets/04.jpg")] private const EmbedJPG3:Class;						
		
		private var _currentImageIndex:int = 0;
		
		private var _debugTF:TextField;
		private var _image	:Sprite;

		public function GestureExample()		{
			
		}
		override protected function atAddedToStage():void {
			super.atAddedToStage();
			stage.align = "tl";
			stage.scaleMode = "noScale";
			
			// 將 Multitouch 設定為手勢事件
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			
			
			
			// 文字格式
			var tf:TextFormat = new TextFormat();
			tf.size = 14 * DeviceUtil.dpiScale;
			
			var title:TextField = new TextField;
			addChild(title);
			title.defaultTextFormat = tf;
			title.text = "Adobe AIR GestureEvents\n上下播動切換圖片\n二指向外可放大圖片\n二指旋轉可旋轉圖片";
			title.autoSize = TextFieldAutoSize.LEFT;
			title.x = 2;
			title.y = DeviceUtil.actionBarHeight;
			title.mouseEnabled = false;
			
			// 測試用的文字
			tf.size = 14 * DeviceUtil.dpiScale;
			_debugTF = new TextField();
			_debugTF.width = 480;
			_debugTF.height = 800;
			_debugTF.mouseEnabled = false;
			_debugTF.autoSize = TextFieldAutoSize.LEFT;
			_debugTF.multiline = true;
			_debugTF.defaultTextFormat = tf;
			_debugTF.x = 2;
			_debugTF.y = title.textHeight + 2;			
			addChild(_debugTF);
			
			// 是否支援手勢事件	
			if (Multitouch.supportsGestureEvents) {
				_debugTF.text = " touchPoints:" + Multitouch.maxTouchPoints;									
				_debugTF.appendText( "\n" + Multitouch.supportedGestures);
			}else {
				_debugTF.text = "not supports gesture events";
			}
			
			
			
		
			// 啟動時, 加入一張預設的圖片
			_image = addNewImage();	
			// 讓圖片完全的置中
			_image.x = stage.stageWidth >> 1;
			_image.y = stage.stageHeight >> 1;
			/*
			 * 
			 * >> 二個大於符號, 是數位邏輯裡的位元移動
			 * 十進位的 8 , 等於二進位的 1000
			 * 8 >> 1 指的就是把數值轉成二進位後, 向右移一個元位
			 * 也就是變成二進位的 100 , 等於十進位 4 
			 * 簡單來說, 就是得到數值的一半
			 * 最大的優點就是結果一定是整數, 
			 * Flash 裡物件座標是整數時, 呈現的效果才會是最佳。
			 * 但要注意運算的優先權問題
			 * 先乘除, 後加減, 最後才是邏輯運算
			 * 8 * 0.5 + 1 = 5
			 * 8 / 2 + 1 = 5
			 * 8 >> 1 + 1 = 2
			 * 因為要先 1+ 1, 然後才位元的移動
			 * */
			
			
			

			// 偵聽裝置旋轉事件
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE , onOrientationChangeHandler);			
			// 偵聽放大的手勢事件
			stage.addEventListener(TransformGestureEvent.GESTURE_ZOOM, onZoomHandler);
			// 偵聽旋轉的手勢事件
			stage.addEventListener(TransformGestureEvent.GESTURE_ROTATE, onRotateHandler);
			// 偵聽二指移動事件
			stage.addEventListener(TransformGestureEvent.GESTURE_PAN, onPanHAndler);
			// 偵聽手勢快速撥動事件
			stage.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipeHandler);
			
		}
		
		
		
		
		private function onOrientationChangeHandler(e:StageOrientationEvent):void {
			_debugTF.text = stage.orientation + "," + stage.stageWidth + "x" + stage.stageHeight;
			_image.x = stage.stageWidth * 0.5;
			_image.y = stage.stageHeight * 0.5;
		}
		
		/**
		 * 加入新的圖片
		 */
		private function addNewImage():Sprite {				
			// 用字串的方式, 得到該變數
			var cls:Class = this["EmbedJPG" + _currentImageIndex];
			// 建構新的圖片
			var jpg:Bitmap = new cls() as Bitmap;			
			// 讓圖片置中
			jpg.x -= jpg.width >> 1;	
			jpg.y -= jpg.height >> 1;
			
			// 建立一個新的 Sprite
			var mc:Sprite = new Sprite();			
			mc.addChild(jpg);
			mc.cacheAsBitmap = true;
			mc.cacheAsBitmapMatrix = new Matrix();
			mc.scaleX = DeviceUtil.devicesScale;
			mc.scaleY = DeviceUtil.devicesScale;
			
			// 目前的圖片索引值加 1
			_currentImageIndex++;
			//  % 百分比符號, 指的是取餘數
			// 用意是要讓圖片索引值 0,1,2,3 的循環
			_currentImageIndex %= 4;	
			
			trace("addNewImage() index:" + _currentImageIndex);		
			addChild( mc );
			
			return mc;
		}
		
		private function onSwipeHandler(e:TransformGestureEvent):void {
			_debugTF.text = "onSwipe:" + e.offsetX + "," + e.offsetY;
			
			// 如果水平, 垂直皆為 0 , 表示沒有播動
			if (e.offsetX == 0 && e.offsetY ==0) {
				return;
			}			
		
			// 計算目前的水平, 垂直座標
			var sw2:int = stage.stageWidth * 0.5;
			var sh2:int = stage.stageHeight * 0.5;
			
			// 建立新的圖片物件
			var newChild:Sprite = addNewImage();		
			
			if (e.offsetX == 1) { // 向右播動				
				// 圖片由左至右進場
				
				newChild.x -= newChild.width;
				newChild.y = sh2;
				
				tween( newChild , { x:sw2 } );				
				tween( _image , { x:stage.stageWidth + _image.width * 0.5 }, true );					
				
			}else if ( e.offsetX == -1) { // 向左
				// 圖片由右至左進場
				
				newChild.x = stage.stageWidth + newChild.width * 0.5;				
				newChild.y = sh2;
				
				tween( newChild , { x:sw2 } );				
				tween( _image , { x:_image.width * -0.5 }, true );
				
			}else if ( e.offsetY == 1) { // 向下
				// 圖片由上至下進場
				
				newChild.x = sw2;
				newChild.y = newChild.height * -0.5 ;
				
				tween( newChild , { y:sh2 } );												
				tween( _image , { y:stage.stageHeight + _image.height * 0.5 }, true );
				
			}else if ( e.offsetY == -1) { //向上
				// 圖片由下至上進場
				newChild.x = sw2;
				newChild.y = stage.stageHeight + newChild.height * 0.5;				
				
				tween( newChild , { y: sh2 } );								
				tween( _image , { y:_image.height * -0.5 }, true );
			}
			
			// 把新的圖片物件存在 _image 變數裡
			_image = newChild;				

		}
		// 先寫好 tween 的函式, 方應製作效果
		private function tween( target:Sprite , prop:Object, remove:Boolean = false):void {			
			prop.ease = Cubic.easeInOut;
			if (remove) {
				//如果是要移除的話, 當 tween 完成時移掉可視物件
				prop.onComplete = function ():void {
					removeChild( target );
				}
				prop.alpha = 0;
			}else {
				target.alpha = 0;
				prop.alpha = 1;
			}
			TweenMax.to( target , .5, prop);			
		}
		
		private function onPanHAndler(e:TransformGestureEvent):void {
			// e.offsetX 水平位移差異。
			// e.offsetY 垂直位移差異。
			_debugTF.text = "onPan:" + e.offsetX + "," + e.offsetY;
			_image.x += e.offsetX;												
			_image.y += e.offsetY;												
		}
		
		private function onZoomHandler(e:TransformGestureEvent):void		{
			// e.scaleX 從前次手勢事件之後的水平縮放
			// e.scaleY	從前次手勢事件之後的垂直縮放
			_debugTF.text = "onZoom:" + e.scaleX + ", " + e.scaleY;
			_image.scaleX *= e.scaleX;
			_image.scaleY *= e.scaleY;
		}
		
		private function onRotateHandler(e:TransformGestureEvent):void		{
			// e.rotation 從前次手勢事件之後的旋轉角度 (以度數為單位)
			_debugTF.text = "onRotate:" + e.rotation;			
			_image.rotation += e.rotation;			
		}
		override protected function atRemovedFromStage():void {
			super.atRemovedFromStage();
			stage.removeEventListener(StageOrientationEvent.ORIENTATION_CHANGE , onOrientationChangeHandler);			
			// 偵聽放大的手勢事件
			stage.removeEventListener(TransformGestureEvent.GESTURE_ZOOM, onZoomHandler);
			// 偵聽旋轉的手勢事件
			stage.removeEventListener(TransformGestureEvent.GESTURE_ROTATE, onRotateHandler);
			// 偵聽二指移動事件
			stage.removeEventListener(TransformGestureEvent.GESTURE_PAN, onPanHAndler);
			// 偵聽手勢快速撥動事件
			stage.removeEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipeHandler);
		}
	}
}