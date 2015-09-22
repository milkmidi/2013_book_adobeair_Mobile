/**
 * @author milkmidi
 */
package com.milkmidi.jumper {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.sensors.Accelerometer;
	import flash.text.TextField;
	import flash.utils.setTimeout;	
	public class MainEntry extends Sprite {
		// 場景上已存在的元件
		// 顯示分數用的動態文字
		public var score_txt:TextField; 
		// 貓咪元件
		public var cat_mc	:MovieClip;
		// 背景圖
		public var bg_mc	:MovieClip;
		
		// 三軸加速器物件
		private var _accel			:Accelerometer;
		// 三軸加速器, x 軸的變化值
		private var _accX			:Number = 0.0;		
		// 目前的分數
		private var _score			:Number = 0;		
		// 存放雲物件的陣列
		private var _clouds			:Vector.<MovieClip>;
		
		// y 軸的速率
		private var _velocityY		:Number;		
		// 場景高度的一半
		private var stageHeightHalf	:Number;		
		
		// 常數宣告
		// 重力加速度
		private static const G:Number = 0.8;
		// 每次踩到雲時, 要增加的速率, 因為 y 軸往上是負的, 所以為負值
		private static const ADD_VELOCITY_Y:Number = -20;
		// 一次要呈現幾個雲物件
		private static const CLOUD_COUNT:int = 6;
		
		// 餅干物件, 吃了就可以大跳躍
		private var _powerMC	:MovieClip;
		
		public function MainEntry() {
				
			// 場景對齊左上角, 且不縮放
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// 讓背景圖的大小等於場景的大小
			bg_mc.width = stage.fullScreenWidth;
			bg_mc.height = stage.fullScreenHeight;
			
			// 啟動點陣圖快取
			bg_mc.cacheAsBitmap = true;						
			cat_mc.cacheAsBitmap = true;						
			
			// 取得場景高度的一半
			stageHeightHalf = stage.fullScreenHeight / 2;
			
			// 建立三軸加速感應器物件
			_accel = new Accelerometer();
			// 偵聽變化
			_accel.addEventListener( AccelerometerEvent.UPDATE , onAccUpdateHandler );				
			
			// 建立限定型別且限定長度的陣列
			_clouds = new Vector.<MovieClip>(CLOUD_COUNT, true);			
			for ( var i:int = 0 ; i < CLOUD_COUNT ; i++ ) {
				var cloud:MovieClip = new Cloud_mc;
				cloud.cacheAsBitmap = true;
				cloud.x = Math.random() * stage.stageWidth;
				cloud.y = 20 + i * stage.stageHeight / 6;				
				_clouds[ i ] = cloud;
				addChild( cloud );
			}				
			
			// 建立餅干元件
			_powerMC = new Power_mc();
			_powerMC.cacheAsBitmap = true;
			this.addChild( _powerMC );
			
			// 開始遊戲
			startGame();			
		}
		private function startGame():void {
			// 分數規零
			_score = 0;
			// 顯示用的文字也設成0
			score_txt.text = "0";			
			_accX = 0;
			
			// 讓貓咪元件 x 軸在場景寬的一半
			cat_mc.x = stage.stageWidth / 2;
			// y 軸在場景高度的一半
			cat_mc.y = stageHeightHalf;
			
			// 餅干元件隨機出現
			_powerMC.x = stage.stageWidth * Math.random();
			_powerMC.y = stage.stageHeight * Math.random();			
			
			// 速率等於預設值
			_velocityY = ADD_VELOCITY_Y;
			// 偵聽 Event.ENTER_FRAME 事件
			addEventListener( Event.ENTER_FRAME , onGameEnterFrameHandler );
		}		
		private function onAccUpdateHandler( e:AccelerometerEvent ):void {
			// 將 x 軸變化記錄下來
			_accX = -e.accelerationX;
		}		
		private function onGameEnterFrameHandler( e:Event ):void {
			// 貓咪依 x 軸加速度的變化往反方向移動
			cat_mc.x += _accX * 20;									
			cat_mc.rotation = _accX * 10;
						
			// 速率會受到動力的影響, 不斷的累加。
			_velocityY += G;				
			
			// 如果貓咪碰撞到餅干物件
			if (_powerMC.hitTestObject( cat_mc )) {
				// 就讓速率為預設值的 2 倍
				_velocityY = ADD_VELOCITY_Y * 2;
			}
			
			// 遊戲的核心程式碼
			// 當貓咪元件 y 軸超過場景高的一半, 且是往上跳時			
			if ( ( cat_mc.y > stageHeightHalf ) && ( _velocityY < 0 ) ) {					
				// 讓貓咪元件 y 軸加上速率
				cat_mc.y += _velocityY;	
			}else {
				var cloud	:MovieClip;			
				// 速率大於 0 , 表示貓咪元件正往下掉時
				if ( _velocityY > 0 ) {							
					cat_mc.y += _velocityY;		
					// 檢查此時是否有碰撞到雲物件
					for each( cloud in _clouds) {
						if ( cat_mc.hitTestObject( cloud ) ) {
							_velocityY = ADD_VELOCITY_Y;
						}						
					}					
				}else {
					// 貓咪元件往上跳時
					for each( cloud in _clouds) {
						// 所有的雲元件 y 軸減去速率
						// 產生雲往下移動的效果
						cloud.y -= _velocityY;
						// 如果雲超出場景的高度, 就讓 y 軸座標設回 0
						// 以重復使用物件
						if ( cloud.y > stage.stageHeight ) {
							// x 軸從隨機出現
							cloud.x = Math.random() * stage.stageWidth;							
							cloud.y = 0;
						}
					}	
					// 餅干元件的座標原理同雲物件
					_powerMC.y -= _velocityY;
					if ( _powerMC.y > stage.stageHeight ) {					
						_powerMC.x = Math.random() * stage.stageWidth;							
						_powerMC.y = 0;
					}
					
					// 分數每次加 5
					_score += 5;
					// 顯示在文字上
					score_txt.text = _score + "";
				}
			}			
		
			// 當 cat 元件超出畫面的最左邊時, 就移動到畫面的最右邊
			if ( cat_mc.x < 0 ){
				cat_mc.x = stage.stageWidth;
			}
			// 當 cat 元件超出畫面的最右邊時, 就移動到畫面的最左邊
			else if ( cat_mc.x > stage.stageWidth ){
				cat_mc.x = 0;
			}
			
			// cat 元件超出畫面的高度時, 遊戲失敗
			if ( cat_mc.y > stage.stageHeight ) {	
				gameOver();				
			}
		}
		private function gameOver():void {
			// 遊戲結束
			removeEventListener( Event.ENTER_FRAME , onGameEnterFrameHandler );
			
			// 建立再玩一次的畫面
			var playAgain:PlayAgain_mc = new PlayAgain_mc;
			playAgain.x = stage.stageWidth * 0.5;
			playAgain.y = stage.stageHeight * 0.5;
			// 點擊後, 重新開始遊戲。
			playAgain.addEventListener(MouseEvent.CLICK , function (e:MouseEvent):void {
				playAgain.removeEventListener( e.type , arguments.callee);
				removeChild( playAgain );
				startGame();
			})
			this.addChild( playAgain );						
		}	
	} 
}