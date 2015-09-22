package com.milkmidi.qnx.views {
	import flash.events.Event;
	import milkmidi.qnx.view.View;
	import qnx.ui.core.Container;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.core.Spacer;
	import qnx.ui.data.DataProvider;
	import qnx.ui.listClasses.DropDown;
	import qnx.ui.picker.Picker;
	/**
	 * ...
	 * @author milkmidi
	 */
	public class PickerDemo extends View {
		
		public function PickerDemo() {
			
		}
		override protected function init():void {
			super.init();
			this.padding = 10;
			this.margins = new <Number>[10,10,10,10];
			this.debugColor = 0xff0000;		
			
			createDropDown();			
			createPicker();		        
		}
		
		private function createDropDown():void {			
			var datas:Array = [];			
            datas.push( { label: "Android" } );			
            datas.push( { label: "iPhone3" } );			
            datas.push( { label: "iPhone4" } );			
            datas.push( { label: "iPad" } );			
            datas.push( { label: "WP7" } );			
            datas.push( { label: "BlackBerry" } );					
			
            var dropDown:DropDown = new DropDown();       
			// 未選擇時的預設文字
            dropDown.prompt = "Select";                
			// 資料來源
            dropDown.dataProvider = new DataProvider(datas);            
			// 當按下時, 出現的下拉選單要加入至那個容器裡
			dropDown.dropDownParent = this;
			// 偵聽選擇事件
            dropDown.addEventListener(Event.SELECT, onSelect);
            addChild(dropDown);		
		}
		
		private function createPicker():void {
			
			var space:Spacer = new Spacer(50,SizeUnit.PIXELS);
			addChild( space);
			
			
				
			var i:int = 0;			
			// 加入小時的資料
			var hours:DataProvider = new DataProvider();
			for ( i = 0; i <= 11; ++i) {				
				hours.addItem( { label:( i == 0 ) ? "12" : i });
			}			
			// 加入分的資料
			var minutes:DataProvider = new DataProvider();
			for ( i = 0; i < 60; ++i) {				
				minutes.addItem( { label: ("" + Math.floor(i / 10)) +"" + (i % 10) } );								
			}
			
			var ampm:DataProvider = new DataProvider();			
			ampm.addItem( { label:"AM" });
			ampm.addItem(  { label:"PM" } );
			
			var dp:DataProvider = new DataProvider();
			dp.addItem( hours );
			dp.addItem( minutes );
			dp.addItem( ampm );			
			
			var picker:Picker = new Picker();	
			picker.dataProvider = dp;
			addChild( picker );
		}
		
		
		private function onSelect(e:Event):void {
			     trace("selected index: " + e.target.selectedIndex);
            
            var myObj:Object = new Object();
            myObj = e.target.selectedItem;
            trace("Selected Item: " + myObj.label);
		}
		
	}

}