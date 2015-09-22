package com.milkmidi.extensions{
	import com.adobe.nativeExtensions.Vibration;
	import com.milkmidi.android.extensions.AndriodExtension;
	import flash.desktop.NativeApplication;
	import flash.display.*;
	import flash.events.*;
	import flash.system.Capabilities;
	import flash.text.*;
	import milkmidi.qnx.display.QnxMain;
	import milkmidi.qnx.utils.QNXFactory;
	import milkmidi.utils.DeviceUtil;
	import qnx.ui.core.ContainerAlign;
	
	/**
	 * ...
	 * @author milkmidi
	 */
	public class MainEntry extends QnxMain {
		// 輸出用的文字
		private var _tf			:TextField;
		// AndriodExtension 類別
		private var _extension	:AndriodExtension;
		public function MainEntry() {			
			super(false);
		}
		override protected function createChildren():void {
			
			addChildAt( _tf = new TextField() , 0);
			_tf.mouseEnabled = false;
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_tf.defaultTextFormat = new TextFormat(null, 12 * DeviceUtil.dpiScale, 0x000000);			
			_tf.x = 10;
			_tf.y = DeviceUtil.actionBarHeight;								
			
			container.padding = 20;			
			container.align = ContainerAlign.FAR;
			
			QNXFactory.labelButton( container , "toast", clickHandler );
			QNXFactory.labelButton( container , "alertDialog", clickHandler );
			QNXFactory.labelButton( container , "timePickerDialog", clickHandler );			
			QNXFactory.labelButton( container , "vibration", onVibrationClickHandler );	
		
			// 建立 AndriodExtension 類別
			_extension = new AndriodExtension();
			// 偵聽原生程式所發出的非同步事件
			_extension.addEventListener(StatusEvent.STATUS, onExtensionStatusHandler);		
		
			stage.addEventListener(Event.DEACTIVATE, function ():void {
				NativeApplication.nativeApplication.exit();
			});
			
		
		}
		
		private function onVibrationClickHandler(e:MouseEvent):void {
			log( 'call("Vibration")'  );	
			_extension.toast("Vibration isSupported:" + Vibration.isSupported);			
			if (Vibration.isSupported) {				
				var vibration:Vibration = new Vibration;
				vibration.vibrate( 2000 );
			}else {
				
			}
		}
		
		private function clickHandler(e:MouseEvent):void {
			switch (e.currentTarget.label) {
				case "toast":
					// 呼叫原生程式裡的 toast 函式
					_extension.toast("呼叫 Android Toast");
					break;
				case "alertDialog":
					// 呼叫原生程式裡的 alertDialog 函式
					_extension.alertDialog("標題","AIR 呼叫 Android");
					break;				
				case "timePickerDialog":
					// 呼叫原生程式裡的 timePickerDialog 函式
					_extension.timePickerDialog();
					break;			
				
			}
			log( 'call("' + e.currentTarget.label + '")'  );			
		}				
		
	
		private function onExtensionStatusHandler(e:StatusEvent):void {
			log( "Status:" + e.code +"," + e.level);							
			switch (e.code) {
				case "timePickerDialog":
					_extension.toast("date:" + e.level);					
					break;				
			}
		}		
		private function log(s:String):void {			
			_tf.appendText(s + "\n");
		}
		
	
	}
	
}