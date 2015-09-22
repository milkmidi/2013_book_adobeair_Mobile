/**
 * @author milkmidi
 * @date created 2012/04/27/
 */
package com.milkmidi.qnx.views {		
	import milkmidi.book2013.model.CommonModel;
	import milkmidi.qnx.display.Toast;
	import milkmidi.qnx.view.IView;
	import milkmidi.qnx.view.View;
	import qnx.ui.core.Container;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.data.DataProvider;
	import qnx.ui.events.ListEvent;
	import qnx.ui.listClasses.List;
	import qnx.ui.listClasses.ListSelectionMode;
	
	public class ListAllView extends View{		
		private static const ITEMS	:Array = [
			{ label:"BasicLayout" , view:BasicLayout } , 
			{ label:"ContainerPropertyDemo" , view:ContainerPropertyDemo },			
			{ label:"ButtonsDemo" , view:ButtonsDemo } , 
			{ label:"TextDemo" , view:TextDemo },
			{ label:"ScrollPaneDemo" , view:ScrollPaneDemo } 	,			
			{ label:"PickerDemo" , view:PickerDemo } 	,			
			{ label:"ListDemo" , view:ListDemo } 	,					
			{ label:"ButtonSkinDemo" , view:ButtonSkinDemo } 	,					
			{ label:"SliderDemo" , view:SliderDemo } 	,					
			{ label:"ToastDemo" , view:ToastDemo } 	,					
			{ label:"DialogView" , view:DialogView } 	,					
			{ label:"ContainerLayout" , view:ContainerLayout } 
			//{ label:"SkinDemo" , view:ButtonSkinDemo } 	
		];
			
	
		public function ListAllView()  {			
			
		}		
		override protected function init():void {			
			super.init();
			var list:List = new List();
			list.dataProvider = new DataProvider( ITEMS );			
			list.size = 100;			
			list.sizeUnit = SizeUnit.PERCENT;			
			list.selectionMode = ListSelectionMode.SINGLE;
			list.addEventListener(ListEvent.ITEM_CLICKED , function (e:ListEvent):void {
				//trace( e );
				navigator.pushView( new e.data.view as IView );
				
				CommonModel.instance.onActionBarLabelChange.dispatch( e.data.label );
				
				//trace( navigator.length );
			});
			addChild( list );
		}
		
		private function onItemClickedHandler(e:ListEvent):void {
			Toast.makeText( stage , e.data.label ).show();
		}
		
		
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package