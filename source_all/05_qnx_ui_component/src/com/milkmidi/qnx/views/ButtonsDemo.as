package com.milkmidi.qnx.views {
	import milkmidi.qnx.view.View;
	import qnx.ui.buttons.BackButton;
	import qnx.ui.buttons.CheckBox;
	import qnx.ui.buttons.IconButton;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.buttons.LabelPlacement;
	import qnx.ui.buttons.RadioButton;
	import qnx.ui.buttons.SegmentedControl;
	import qnx.ui.buttons.ToggleSwitch;
	import qnx.ui.core.Container;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.data.DataProvider;
	
	/**
	 * ...
	 * @author milkmidi
	 */
	public class ButtonsDemo extends View {
		

		[Embed(source="../../../../assets/menu_about_f.png")]
		private static const ICON:Class;
		public function ButtonsDemo() {
			
		}
		override protected function init():void {
			this.padding = 10;
			this.margins = new <Number>[10,10,10,10];
			this.debugColor = 0xff0000;		
			
			var labelBtn:LabelButton = new LabelButton();
			labelBtn.size = 50;			
			labelBtn.label = "Label Button";
			addChild(labelBtn);
			
			var iconBtn:IconButton = new IconButton();
			iconBtn.size = 60;			
			iconBtn.setIcon( new ICON );			
			iconBtn.toggle = true;			
			addChild(iconBtn);
			
			var backBtn:BackButton = new BackButton();
			backBtn.width = 200;
			backBtn.label = "Go Back";
			addChild(backBtn);

	
			
			var cb:CheckBox = new CheckBox();
			cb.label ="CheckBox";
			cb.width = 150;
			cb.labelPlacement = LabelPlacement.RIGHT;
			cb.labelPadding = 30;
			addChild(cb);

			var rb1:RadioButton = new RadioButton();
			rb1.size = 30;
			rb1.sizeUnit = SizeUnit.PIXELS;
			rb1.groupname = "group1";
			rb1.label = "Yes";
			rb1.selected = true;
			addChild(rb1);
			
			var rb2:RadioButton = new RadioButton();
			rb2.size = 30;
			rb2.sizeUnit = SizeUnit.PIXELS;
			rb2.groupname = "group1";
			rb2.label = "No";
			addChild(rb2);
			
			var segData:Array = [ { label:"Android" }, { label:"iOS" }, { label:"BlackBerry" } ];						
			var seg:SegmentedControl = new SegmentedControl();
			seg.dataProvider = new DataProvider(segData);
			seg.selectedIndex = 1;
			addChild(seg);

			var tog:ToggleSwitch = new ToggleSwitch();
			tog.selectedLabel = "ON";
			tog.defaultLabel = "OFF";			
			addChild( tog );
			
			
			
		}
		
	}

}