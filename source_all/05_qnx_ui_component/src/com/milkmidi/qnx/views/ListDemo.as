/**
 * @author milkmidi
 * @date created 2012/04/27/
 */
package com.milkmidi.qnx.views {		
	import milkmidi.qnx.display.Toast;
	import milkmidi.qnx.view.View;
	import qnx.ui.core.Container;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.data.DataProvider;
	import qnx.ui.events.ListEvent;
	import qnx.ui.listClasses.List;
	import qnx.ui.listClasses.ListSelectionMode;
	
	public class ListDemo extends View{		
		
		//__________________________________________________________________________________ Constructor
		public function ListDemo()  {			
			
		}		
		override protected function init():void {			
			super.init();
			this.padding = 10;
			this.margins = new <Number>[10,10,10,10];
			this.debugColor = 0xff0000;		
			
			var data:Array = [];
			for (var i:int = 0; i < 100; i++) {
				data.push( { label:"Label " + i } );				
			}           
			
			var list:List = new List();
			list.dataProvider = new DataProvider( data );			
			list.size = 100;			
			list.sizeUnit = SizeUnit.PERCENT;
			// 單選模式
			list.selectionMode = ListSelectionMode.SINGLE;
			list.addEventListener(ListEvent.ITEM_CLICKED , onItemClickedHandler);
			addChild( list );		
		}
		
		private function onItemClickedHandler(e:ListEvent):void {
			Toast.makeText( stage , e.data.label ).show();
		}
		
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package