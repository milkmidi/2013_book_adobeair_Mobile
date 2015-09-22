/**
 * @author milkmidi
 */
package com.milkmidi.qnx.views {		
	import com.milkmidi.qnx.skin.MyButtonSkin;
	import com.milkmidi.qnx.skin.MyLabelButton;
	import milkmidi.qnx.view.View;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.core.Container;
	import qnx.ui.text.Label;
	
	public class ButtonSkinDemo extends View{		
		
		//__________________________________________________________________________________ Constructor
		public function ButtonSkinDemo()  {			
			
		}		
		override protected function init():void {
			super.init();
			
			this.padding = 5;
			
			// 預設
			var labelBtn:LabelButton = new LabelButton();
			labelBtn.label = "Default";
			labelBtn.width = 300;
			addChild( labelBtn );
			
			labelBtn = new LabelButton();
			labelBtn.label = "setSkin";
			// 更換樣式
			labelBtn.setSkin( MyButtonSkin );
			labelBtn.width = 300;
			addChild( labelBtn );
			
			labelBtn = new MyLabelButton;
			labelBtn.width = 300;
			labelBtn.label = "setSkinAndTextField";			
			addChild( labelBtn );
			
		}
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package