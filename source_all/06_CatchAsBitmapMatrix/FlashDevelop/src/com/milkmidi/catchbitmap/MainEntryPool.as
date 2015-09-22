package com.milkmidi.catchbitmap {
	import com.milkmidi.catchbitmap.cast.PoolBoxMC;
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.utils.getTimer;
	import milkmidi.qnx.display.QnxMain;
	import milkmidi.qnx.utils.QNXFactory;
	import milkmidi.utils.DeviceUtil;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.core.ContainerAlign;
	import qnx.ui.text.Label;
	import swc.Box_mc;
	import swc.SampleAni_mc;
	/**
	 * ...
	 * @author milkmidi
	 */
	[SWF(width = "960", height = "640", frameRate = "30", backgroundColor = "#ffffff")]
	public class MainEntryPool extends QnxMain {
		// 物件數量
		private static const SPRITE_COUNT:uint = 60;		
		
		// 物件的容器
		private var _objContainer:Sprite;		
		
		// 按鈕的名稱
		private static const LABELS:Array = [
			"noCatch1",
			"noCatch2",
			"catchAsBitmap1" , 
			"catchAsBitmap2" , 
			"catchAsBitmapMatrix1",
			"catchAsBitmapMatrix2", 
			"catchAsBitmapAndMatrix1",
			"catchAsBitmapAndMatrix2", 
			"clear"
		];
		
		// 顯示用的 Label
		private var _label:Label;
		
		public function MainEntryPool() {			
			super(true);
		}
		override protected function createChildren():void {
			
			
			
			addChild(_objContainer = new Sprite);
			// 取消滑鼠感應功能
			_objContainer.mouseEnabled = false;
			_objContainer.mouseChildren = false;
			_objContainer.y = DeviceUtil.actionBarHeight;
			
			// 讓按鈕元件置右邊
			container.align = ContainerAlign.FAR;
			
			// 加入 Label 元件
			container.addChild( _label = new Label);
			// 指定子物件的間距
			container.padding = 10;			
			
			_label.width = 300;
			
			// 加入按鈕件
			for (var i:int = 0; i < LABELS.length; i++) {
				var btn:LabelButton = QNXFactory.labelButton( container ,  LABELS[i] , onClickHandler);				
				btn.width = 300;
			}									
			
			// 建立一個測試用的動畫
			var ani:MovieClip = addChild( new SampleAni_mc ) as MovieClip;
			ani.mouseEnabled = false;
			ani.mouseChildren = false;			
			ani.scaleX = DeviceUtil.devicesScale;
			ani.scaleY = DeviceUtil.devicesScale;
			ani.y = stage.fullScreenHeight - 100;			
			
			
		}
	
		
		private function enterFrameAni1Handler(e:Event):void {
			var _len:uint = _objContainer.numChildren;
			while (_len--) {
				var _dis:MovieClip = _objContainer.getChildAt(_len) as MovieClip;	
				_dis.x += 10;
				if (_dis.x > stage.stageWidth) {
					_dis.x = -10;
				}
			}
		}		
		private function enterFrameAni2Handler(e:Event):void {
			var _len:uint = _objContainer.numChildren;
			var _time:Number = getTimer() / 1000;			
			while (_len--) {
				var _dis:MovieClip = _objContainer.getChildAt(_len) as MovieClip;							
				_dis.x -= (_dis.x - Math.random() * stage.stageWidth) * 0.25;				
				_dis.y -= (_dis.y - Math.random() * stage.stageHeight * .5) * 0.25;					
				var _pcercent:Number = _time * _dis.percent;				
				_dis.rotation += _dis.tr;				
				_dis.alpha = Math.sin(_pcercent) * 0.5 + 0.5;	
				_dis.scaleX = Math.sin(_pcercent) * 0.5 + 0.5;
				_dis.scaleY = _dis.scaleX;
			}			
		}
		
		private function onClickHandler(e:MouseEvent):void {
			// 移除目前測試用的元件
			while (_objContainer.numChildren) {				
				PoolBoxMC(_objContainer.getChildAt( 0 )).recycle();								
			}
			
			// 得到按下的按鈕名稱
			var label:String = e.currentTarget.label;
			if (label == "clear") {
				_label.text = "";
				return;
			}
			// 顯示目前測試用的西稱
			_label.text = label;
			
			
			// 依名稱決定要使用那種動態效果
			var index:int = LABELS.indexOf( label );						
			removeEventListener(Event.ENTER_FRAME , enterFrameAni1Handler);
			removeEventListener(Event.ENTER_FRAME , enterFrameAni2Handler);
			// 因為測試用的動態是二個一組, 所以使用取 2 餘數就可以得知是 0 還是 1
			if (index % 2 == 0) {							
				addEventListener(Event.ENTER_FRAME , enterFrameAni1Handler);
			}else {
				addEventListener(Event.ENTER_FRAME , enterFrameAni2Handler);
			}
			
			// 建立取快用的 MAtrix
			var matrix:Matrix = new Matrix;
			for (var i:int = 0; i < SPRITE_COUNT; i++) {
				var _mc:PoolBoxMC = PoolBoxMC.obtain();
				_mc.x = Math.random() * stage.stageWidth;
				_mc.y = Math.random() * stage.stageHeight;
				_mc.percent = Math.random() + 0.1;
				_mc.tr = Math.random() * 10 - 5;				
				_mc.ta = Math.random();
				_mc.sx = Math.random() * 50 - 25;				
				_mc.sy = Math.random() * 50 - 25;		
				_mc.scaleX = DeviceUtil.devicesScale;
				_mc.scaleY = DeviceUtil.devicesScale;
				
				switch (index) {
					// 0 , 1是使用預設, 什麼都不開啟
					case 2:
					case 3:
						// 只開啟 catchAsBitmap
						_mc.cacheAsBitmap = true;
						break;
					case 4:
					case 5:
						// 只開啟 catchAsBitmapMatrix
						_mc.cacheAsBitmapMatrix = matrix;
						break;
					case 6:
					case 7:
						// 二者皆開啟
						_mc.cacheAsBitmapMatrix = matrix;
						_mc.cacheAsBitmap = true;
						break;
				}
				_objContainer.addChild(_mc);	
			}
		}
		override protected function atRemovedFromStage():void {
			super.atRemovedFromStage();
			while (_objContainer.numChildren) {				
				PoolBoxMC(_objContainer.getChildAt( 0 )).recycle();								
			}
			removeEventListener(Event.ENTER_FRAME , enterFrameAni1Handler);
			removeEventListener(Event.ENTER_FRAME , enterFrameAni2Handler);
		}
		
	}

}

