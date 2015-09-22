package  com.milkmidi.android.extensions {	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class AndriodExtension extends EventDispatcher {		 
		// extension 視別用的 id, 需和 extension.xml 裡的 id 相同
		private static const EXTENSION_ID:String = "com.milkmidi.android.extensions";		
		
		// 建立 ExtensionContext 原生程式呼叫的介面
        private var _context:ExtensionContext;	
		

        public function AndriodExtension() {					
			_context = ExtensionContext.createExtensionContext( EXTENSION_ID, null);					
			if (_context) {
				_context.addEventListener(StatusEvent.STATUS, dispatchEvent);								
			}
        }				
		/**
		 * 呼叫 Android 產生 Toast 提示視窗元件
		 * @param val 要顯示的文字
		 */
		public function toast( val:String):void {	
			_context.call("toast", val);						
		}
		
		/**
		 * 呼叫 Android 產生 AlertDialog
		 * @param	pTitle 標題
		 * @param	pMessage 文字
		 */
        public function alertDialog(pTitle:String, pMessage:String):void {			
			_context.call("alertDialog", pTitle, pMessage);			
        }
		/**
		 * 呼叫 Android 產生 TimePickerDialog, 日期選擇視窗
		 */
		public function timePickerDialog():void {
			_context.call("timePickerDialog");
		}
		
		/**
		 * 摧毀物件
		 */
		public function dispose():void {
			_context.dispose();
			_context = null;
		}
		
    }

}

