/**
 * @author milkmidi
 */
package milkmidi.utils {		
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class SimpleButtonProxy {		
		
		// MovieClip 實體物件
		private var _mc:MovieClip;		
		
		// 得到 MovieClip 實體物件, 唯讀屬性
		public function get mc():MovieClip {	
			return this._mc;	
		}
		
		// CLICK 的偵聽函式
		private var _clickListener:Function;	
		
		/**
		 * 建立簡單按鈕類別
		 * @param	pMC MovieClip 物件
		 * @param	pContainer 要被加入到那個容器物件裡
		 */
		public function SimpleButtonProxy( pMC:MovieClip , pContainer:Sprite = null )  {			
			this._mc = pMC;
			// 偵聽按下事件
			this._mc.addEventListener(MouseEvent.MOUSE_DOWN , onMouseDownHandler);
			// 偵聽當從場景上移除了
			this._mc.addEventListener(Event.REMOVED_FROM_STAGE , onRemovedFromStageHandler);			
			this._mc.gotoAndStop(1);		
			// 取消其子物件的滑鼠感應功能
			this._mc.mouseChildren = false;
			// 啟用按鈕模式
			this._mc.buttonMode = true;			
			if (pContainer != null) {				
				pContainer.addChild( pMC );
			}
		}		
		
	
		
		// 偵聽 CLICK 事件		 
		public function addClick( pClickListener:Function ):void {				
			this._clickListener = pClickListener;
			this._mc.addEventListener(MouseEvent.CLICK , pClickListener );
		}
		
		// 當滑鼠按下時的偵聽函式		 
		private function onMouseDownHandler(e:MouseEvent):void {
			// 移至第二影格
			this._mc.gotoAndStop(2);
			
			// 偵聽 Stage 的滑鼠放開事件
			this._mc.stage.addEventListener(MouseEvent.MOUSE_UP , function (evt:MouseEvent):void {
				// 取消 Stage 的滑鼠放開事件偵聽
				evt.currentTarget.removeEventListener( evt.type , arguments.callee);
				// 移回第一影格
				_mc.gotoAndStop(1);
			});
		}
		
		// 從場景上移除時, 取消所有偵聽
		private function onRemovedFromStageHandler(e:Event):void {
			this._mc.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler);
			this._mc.removeEventListener(MouseEvent.CLICK , _clickListener );
			this._clickListener = null;
			this._mc = null;			
		}
	}
}