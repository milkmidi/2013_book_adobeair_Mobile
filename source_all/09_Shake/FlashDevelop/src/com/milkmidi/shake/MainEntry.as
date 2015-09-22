package com.milkmidi.shake {
	
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import com.milkmidi.shake.events.ShakeEvent;
	import flash.display.StageAspectRatio;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import milkmidi.display.MSprite;
	import milkmidi.utils.DeviceUtil;
	import swc.Boxel_mc;
	import swc.IntroBG_mc;
	import swc.ShakePhoneTip_mc;
	
	[SWF(width = "480", height = "800", frameRate = "30", backgroundColor = "#ffffff")]
	public class MainEntry extends MSprite {
		
	
		// swc 裡的進場動畫
		private var _bg		:IntroBG_mc;
		
		// 抽抽樂機元件
		private var _box	:Boxel_mc;
		
		// 搖晃偵聽器
		private var _shakeDetecter:ShakeDetecter;
		private var tip:ShakePhoneTip_mc;
		
		public function MainEntry() {			
			CONFIG::debug {
				DeviceUtil.devicesScale = 0.5;
			}
			super();
		}
		override protected function atAddedToStage():void {
			stage.scaleMode = "noScale";
			stage.align = "tl";
			
			
			DeviceUtil.devicesScaleObj( this );
			
			
			_shakeDetecter = new ShakeDetecter();
			_shakeDetecter.enabled = false;
			_shakeDetecter.addEventListener(ShakeEvent.CHANGE , onShakeChangeHandler);
			_shakeDetecter.addEventListener(ShakeEvent.SHAKE , onShakeHandler);
			
			stage.setAspectRatio( StageAspectRatio.LANDSCAPE );
			
			// 加入進場動畫
			addChild( _bg = new IntroBG_mc);
			// 偵聽影格 48 上的 Event.COMPLETE 事件
			_bg.addEventListener(Event.COMPLETE , onIntroCompleteHandler);			
			
			// 建立抽抽樂機元件, 但先不加到場景上
			_box = new Boxel_mc();
			_box.addEventListener("showResult" , onShowResultHandler);
			_box.gotoAndStop(1);			
			
		}
		private function onIntroCompleteHandler(e:Event):void {
			// 取消偵聽
			_bg.removeEventListener(Event.COMPLETE , onIntroCompleteHandler);
			// 加入抽抽樂機元件
			addChild(_box);
			// 啟用搖晃偵聽器
			_shakeDetecter.enabled = true;
			// 淡入進場
			_box.alpha = 0;
			TweenMax.to( _box , .5, {
				alpha		:1,
				ease		:Cubic.easeInOut
			} );
			
			tip = new ShakePhoneTip_mc;
			//tip.x = 150;
			tip.y = stage.stageHeight *0.5;
			addChild( tip );
		}
			
		
		private function onShowResultHandler(e:Event):void {
			// 取亂數, 有效值為 1 ~ 5
			var frame:int = int( Math.random() * 4 + 0.5) + 1;			
			
			_box.result_mc.gotoAndStop( frame );
			// 點擊場景後, 重新開始
			
			setTimeout(function ():void {
				_shakeDetecter.enabled = true;
				_shakeDetecter.addEventListener(ShakeEvent.SHAKE , function (evt:ShakeEvent):void {
					evt.currentTarget.removeEventListener( evt.type , arguments.callee );
					_shakeDetecter.reset();
					_box.gotoAndStop(1);
					_shakeDetecter.addEventListener(ShakeEvent.SHAKE , onShakeHandler);
				});
			},650);
			
		
			/*stage.addEventListener(MouseEvent.CLICK , function ():void {
				stage.removeEventListener(MouseEvent.CLICK , arguments.callee );
				_shakeDetecter.enabled = true;
			});*/
		}
		
	
		private function onShakeHandler(e:ShakeEvent):void {
			// 判斷搖晃次數
			// 超過三次的話, 就播放抽抽樂機裡的動畫
			
			if (tip) {
				removeChild(tip);
				tip.gotoAndStop(1);
				tip = null;
			}
			
			if (_shakeDetecter.shakeCount <= 3) {				
				_box.gotoAndStop( _shakeDetecter.shakeCount );		
			}else {
				_shakeDetecter.enabled = false;
				_shakeDetecter.reset();
				_shakeDetecter.removeEventListener(ShakeEvent.SHAKE , onShakeHandler);
				_box.play();
			}
		}
	
		
		private function onShakeChangeHandler(e:ShakeEvent):void {
			
		}
		override protected function atResize():void {
			_bg.x =  stage.stageWidth >> 1;
			_bg.y =  stage.stageHeight >> 1;		
			_box.x = stage.stageWidth >> 1;
			_box.y = stage.stageHeight * 0.5 + 50;
		}
		override protected function atRemovedFromStage():void {
			super.atRemovedFromStage();
			_shakeDetecter.removeEventListener(ShakeEvent.CHANGE , onShakeChangeHandler);
			_shakeDetecter.removeEventListener(ShakeEvent.SHAKE , onShakeHandler);
			_shakeDetecter.destroy();
			if (tip) {
				removeChild(tip);
				tip.gotoAndStop(1);
				tip = null;
			}
			_box.removeEventListener("showResult" , onShowResultHandler);
		}
	}
}
