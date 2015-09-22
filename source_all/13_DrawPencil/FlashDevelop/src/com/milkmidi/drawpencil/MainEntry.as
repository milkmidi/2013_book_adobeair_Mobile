/**
 * @author milkmidi
 */
package com.milkmidi.drawpencil {		
	import com.milkmidi.drawpencil.cast.CanvasMC;
	import com.milkmidi.drawpencil.cast.ColorPickerMC;
	import com.milkmidi.drawpencil.cast.PencilMC;
	import com.milkmidi.drawpencil.model.PencilEvent;
	import com.milkmidi.drawpencil.model.PencilModel;
	import flash.display.BitmapData;
	import flash.display.PNGEncoderOptions;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import milkmidi.display.MApplication;
	import milkmidi.qnx.display.Toast;
	import milkmidi.utils.DeviceUtil;
	import milkmidi.utils.SimpleButtonProxy;
	import swc.ClearBtn_mc;
	import swc.ColorBtn_mc;
	import swc.SaveBtn_mc;
	
	CONFIG::air{
	import flash.display.StageAspectRatio;
	import flash.display.StageOrientation;
	import flash.media.CameraRoll;
	}
	
	[SWF(width = "960", height = "640", frameRate = "30", backgroundColor = "#ffffff")]
	public class MainEntry extends MApplication {				
		
		// 畫布元件
		private var _canvas			:CanvasMC;
		// 畫筆元件
		private var _pencil			:PencilMC;		
		// 色盤元件
		private var _colorPicker	:ColorPickerMC;		
		// 按鈕的容器
		private var _btnContainer	:Sprite;
		
		public function MainEntry()  {			
			//this.y = -122;
			//CONFIG::debug {
				 //DeviceUtil.devicesScale = 0.5;
			//}
			super();
		}		
		
		override protected function atAddedToStage():void {
			super.atAddedToStage();
			// 建構畫布元件
			addChild( _canvas = new CanvasMC );			
			
			// 建立按鈕
			createButtons();						
			
			// 建立畫筆元件
			addChild( _pencil = new PencilMC );
			DeviceUtil.devicesScaleObj( _pencil );
			
			// 建立色盤元件
			addChild( _colorPicker = new ColorPickerMC );
			DeviceUtil.devicesScaleObj( _colorPicker );
			
			// 偵聽 Model 發出的 PencilEvent.COLOR_CHANGE 事件
			PencilModel.getInstance().addEventListener(PencilEvent.COLOR_CHANGE , onColorPickerChangeHandler);
			
			CONFIG::air{
			stage.setAspectRatio( StageAspectRatio.LANDSCAPE );
			}
		}		
	
		private function createButtons():void {			
			// 建立放置按鈕的容器, 使用 Sprite 物件
			addChild( _btnContainer = new Sprite );
			// 對容器做 CLICK 偵聽
			_btnContainer.addEventListener(MouseEvent.CLICK , onButtonClickHandler);
			
			// 建立 SAVE 按鈕
			var saveBtn:SaveBtn_mc = new SaveBtn_mc();						
			saveBtn.name = "save";						
			saveBtn.x = 0;
			new SimpleButtonProxy( saveBtn , _btnContainer );				
			
			// 建立 CLEAR 按鈕
			var clearBtn:ClearBtn_mc = new ClearBtn_mc();
			clearBtn.name = "clear";
			clearBtn.x = 180;
			new SimpleButtonProxy( clearBtn, _btnContainer );				
			
			// 建立啟動色盤按鈕
			var colorBtn:ColorBtn_mc = new ColorBtn_mc();
			colorBtn.name = "color";
			colorBtn.x = 360;
			new SimpleButtonProxy( colorBtn, _btnContainer );	
			
			_btnContainer.scaleX = DeviceUtil.devicesScale;
			_btnContainer.scaleY = DeviceUtil.devicesScale;
		}
		
		// Model 發出 PencilEvent.COLOR_CHANGE 的處理函式
		private function onColorPickerChangeHandler(e:PencilEvent):void {
			_pencil.color = PencilModel.getInstance().color;
			_canvas.color = PencilModel.getInstance().color;
		}
		
		// 按鈕按下時
		private function onButtonClickHandler(e:MouseEvent):void {
			// 依按到的名稱做對映的事件
			switch (e.target.name) {
				case "save":
					// 將圖片存入至裝置裡的相片集
					doSaveImage();
					break;
				case "clear":
					// 清處重畫
					_canvas.clear();
					break;
				case "color":
					// 啟動色盤
					var event:PencilEvent = new PencilEvent( PencilEvent.COLOR_PICKER_SHOW );
					PencilModel.getInstance().dispatchEvent( event );
					break;
			}
		}
		
		CONFIG::swf
		private function doSaveImage():void {			
			var bitmapData:BitmapData = new BitmapData(stage.fullScreenWidth, stage.fullScreenHeight);												
			// 將 canvas 目前的畫面繪製成 BitmapData
            bitmapData.draw(_canvas);  		
			
			var rect:Rectangle = new Rectangle(0, 0, bitmapData.width, bitmapData.height);
			new FileReference().save( bitmapData.encode( rect, new PNGEncoderOptions() ) , "my.png");
		}
		
		CONFIG::air
		private function doSaveImage():void {			
			// 建立新的 BitmapData, 大小即是目前的裝置解悉度
			var bitmapData:BitmapData = new BitmapData(stage.fullScreenWidth, stage.fullScreenHeight);												
			// 將 canvas 目前的畫面繪製成 BitmapData
            bitmapData.draw(_canvas);  					
			
			
			// 判斷 CameraRoll 是否支援新增 BitmapData
			if (CameraRoll.supportsAddBitmapData) {				
				// 建立 CameraRoll
				var cameraRoll:CameraRoll = new CameraRoll();
				cameraRoll.addEventListener(Event.COMPLETE , function (e:Event):void {
					Toast.makeText( stage, "Save Access!" ).show();
					// 移除偵聽
					e.currentTarget.removeEventListener( e.type , arguments.callee );					
				});
				// 儲存畫好的 BitmapData 
				cameraRoll.addBitmapData( bitmapData );					
			}else {
				Toast.makeText( stage, "not supportsAddBitmapData!" ).show();
			} 
        }		
		override protected function atResize():void {			
			_btnContainer.x = stage.stageWidth - _btnContainer.width >> 1;
			_btnContainer.y = stage.stageHeight - _btnContainer.height -5;
		}
		override protected function atRemovedFromStage():void {
			super.atRemovedFromStage();			
			addEventListener(Event.ENTER_FRAME , function ():void {
				removeEventListener( Event.ENTER_FRAME , arguments.callee );
				PencilModel.getInstance().destroy();				
			});
		}
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package