/**
 * @author milkmidi
 * @date created 2012/12/29/
 */
package milkmidi.book2013 {		
	import com.milkmidi.android.extensions.AndriodExtension;
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;
	import flash.events.StatusEvent;
	import flash.ui.Keyboard;
	import milkmidi.model.MainModel;
	
	[SWF(width = "480", height = "800", frameRate = "34", backgroundColor = "#ededed")]		
	public class MainEntryAndroid extends MainEntry {				
		//__________________________________________________________________________________ Constructor
		public function MainEntryAndroid()  {			
			
		}		
		override protected function onKeyDownHandler(e:KeyboardEvent):void {			
			if (e.keyCode == Keyboard.BACK) {
				e.preventDefault();
				
				if (MainModel.instance.currentIndex != -1) {
					MainModel.instance.currentIndex = -1;
				}else {
					var a:AndriodExtension = new AndriodExtension();
					a.alertDialog("喔, 不", "你真的要離開應用程式嗎?");
					a.addEventListener( StatusEvent.STATUS , function (evt:StatusEvent):void {						
						if (StatusEvent(evt).level == "OK" || StatusEvent(evt).level == "ok") {							
							NativeApplication.nativeApplication.exit();
						}
					});
						
				}				
			}
		}
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package