package com.milkmidi.qnx.views {
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import milkmidi.qnx.view.View;
	import qnx.ui.core.Container;
	import qnx.ui.text.KeyboardType;
	import qnx.ui.text.Label;
	import qnx.ui.text.ReturnKeyType;
	import qnx.ui.text.TextInput;
	import qnx.ui.text.TextInputIconMode;
	/**
	 * ...
	 * @author milkmidi
	 */
	public class TextDemo extends View {
		
		
		public function TextDemo() {
			
		}
		override protected function init():void {
			super.init();			
			this.padding = 10;
			this.margins = new <Number>[10,10,10,10];
			this.debugColor = 0xff0000;		
			
			var input:TextInput = new TextInput();
			input.width = 200;		
			input.clearIconMode = TextInputIconMode.ALWAYS;			
			addChild(input);
			
			var label:Label = new Label();
			label.autoSize = TextFieldAutoSize.CENTER;
			label.wordWrap = true;
			label.multiline = true;
			label.selectable = true;
			label.htmlText = "<p><strong>This is a label!!!</strong></p><br/><b>milkmidi</b>"
			addChild(label);
		}
		
	}

}