/**
 * @author milkmidi
 */
package com.milkmidi.p2p.view {
	import flash.events.MouseEvent;
	import qnx.ui.data.DataProvider;
	import qnx.ui.listClasses.ListSelectionMode;
	
	public class P2PRoom2 extends P2PRoom {
		
		
		override protected function init():void {
			super.init();
			
			var allObj:Object = { label:"ALL", id:"ALL" };		
			
			_userList.dataProvider = new DataProvider([allObj]);			
			_userList.selectionMode = ListSelectionMode.SINGLE;
			_userList.selectedIndex = 0;		
		}
		
	
		override protected function onSubmitClickHandler( e:MouseEvent = null ):void {				
		
			var txt:String = _inputText.text;
			if ( txt.length == 0 ) {
				return;
			}			
			if ( _userList.selectedItem.id == "ALL" ) {				
				super.onSubmitClickHandler( e );
			}else {
				var obj:Object = new Object();
				obj.txt = "[Private]:" + txt;				
				obj.peerID = _p2p.nearID;
				obj.name = _label.text;			
				appendOutput( "[Me]:" + txt );							
				_inputText.text = "";
				_p2p.sendToNearest( obj , _userList.selectedItem.id );				
			}
		}
		
		
		
	
	
	}
}