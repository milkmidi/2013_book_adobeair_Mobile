/**
 * @author milkmidi
 */
package com.milkmidi.p2p.view {
	
	
	
	import com.milkmidi.p2p.skin.MyTileCellRenderer;
	import flash.events.KeyboardEvent;
	import flash.text.TextFormat;
	import com.milkmidi.p2p.events.PeerEvent;
	import com.milkmidi.p2p.utils.PeerGroup;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import milkmidi.utils.DeviceUtil;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.core.Containment;
	import qnx.ui.core.SizeMode;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.data.DataProvider;
	import qnx.ui.data.IDataProvider;
	import qnx.ui.listClasses.List;
	import qnx.ui.text.Label;
	import qnx.ui.text.TextInput;

	CONFIG::air{
		import pl.mateuszmackowiak.nativeANE.progress.NativeProgress;
		import pl.mateuszmackowiak.nativeANE.toast.Toast;
	}
	public class P2PRoom extends Container {
		// 使用者顯示用的名稱
		protected var _label		:TextInput;
		// 發送按鈕
		protected var _submitBtn	:LabelButton;
		// P2P PeeerGroup 類別
		protected var _p2p		:PeerGroup;
		// 顯示目前有多少使用者
		protected var _userList	:List;		
		// 輸入文字
		protected var _inputText	:TextInput;
		// 顯示聊天室的內容的文字
		protected var _outputText	:Label;
		
		private static const SERVER:String = "rtmfp://stratus.adobe.com/";			
		private static const DEVKEY:String = "722d05be12a7e3660881f350-c7b818e2e020";			
		CONFIG::air{
		private var progressPopup:NativeProgress;
		}
		private var _timer		:Timer = new Timer(10000, 1);
		private var _tfm:TextFormat;
		public function P2PRoom() {		
			_tfm = new TextFormat("_sans", 19);
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemovedFromStageHandler);
			super();
		}
	
		
		override protected function init():void {
			super.init();
			
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE , onTimerCompleteHandler);
			
			// 建立 PeerGroup
			_p2p = new PeerGroup( SERVER + DEVKEY, "p2pChat" );						
			_p2p.addEventListener( PeerEvent.NET_CONNECTION_CONNECT_SUCCESS, onP2PStatus );
			_p2p.addEventListener( PeerEvent.NET_GROUP_CONNECT_SUCCESS, onP2PStatus );
			_p2p.addEventListener( PeerEvent.NET_GROUP_NEIGHBOR_CONNECT, onP2PStatus );
			_p2p.addEventListener( PeerEvent.NET_GROUP_NEIGHBOR_DISCONNECT, onP2PStatus );
			_p2p.addEventListener( PeerEvent.NET_GROUP_POSTING_NOTIFY, onP2PStatus );
			
			CONFIG::air{
			if(NativeProgress.isSupported){
				progressPopup = new NativeProgress( 0, NativeProgress.ANDROID_DEVICE_DEFAULT_DARK_THEME);
				progressPopup.setTitle( "Connect"  );
				progressPopup.setMessage( "Loading" );
				progressPopup.show( true );
			}
			}
			
		
			// 左邊紅色區塊
			var leftRed:Container = new Container();
			leftRed.debugColor = 0xff0000;
			leftRed.margins = new <Number>[ 5, 5, 5, 5 ];
			addChild( leftRed );
			
			// 顯示聊天室內容的文字
			_outputText = new Label();
			_outputText.size = 100;
			_outputText.sizeMode = SizeMode.BOTH;
			_outputText.sizeUnit = SizeUnit.PERCENT;
			_outputText.text = "";
			_outputText.format = _tfm;
			leftRed.addChild( _outputText );			
			leftRed.addChild( createSendContainer() );
			
			//右邊用來顯示目前有多少位使用者
			_userList = new List();
			_userList.size = 130 * (DeviceUtil.dpiScale);						
			_userList.dataProvider = new DataProvider();			
			_userList.containment = Containment.DOCK_RIGHT;	
			_userList.setSkin( MyTileCellRenderer );
			addChild( _userList );
		}
		
		override protected function onAdded():void {
			super.onAdded();
			stage.addEventListener(KeyboardEvent.KEY_DOWN , onKeyDownHandler);
		}
		
		private function onKeyDownHandler(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.ENTER) {
				onSubmitClickHandler();
			}
		}
		
		private function onTimerCompleteHandler(e:TimerEvent):void {
			CONFIG::air{
			if (progressPopup) {
				progressPopup.hide( "Connect Time out" );				
			}
			}
		}
		
		private function createSendContainer():Container {
			// 下方綠色區塊
			var sendContainer:Container = new Container( 60, SizeUnit.PIXELS );
			//sendContainer.debugColor = 0x00ff00;			
			sendContainer.margins = new <Number>[ 2, 2, 2, 2 ];
			sendContainer.flow = ContainerFlow.HORIZONTAL;
			
			// 使用者姓名
			_label = new TextInput();
			_label.width = 180;
			_label.format = _tfm;
			sendContainer.addChild( _label );
			
			// 輸入文字
			_inputText = new TextInput();
			_inputText.format = _tfm;
			_inputText.size = 100;
			_inputText.sizeUnit = SizeUnit.PERCENT;
			_inputText.text = "Hi!";
			sendContainer.addChild( _inputText );
			
			// 送出按鈕
			_submitBtn = new LabelButton();
			_submitBtn.label = "Submit";
			_submitBtn.enabled = false;
			_submitBtn.size = 80;
			_submitBtn.addEventListener( MouseEvent.CLICK, onSubmitClickHandler );
			sendContainer.addChild( _submitBtn );
			return sendContainer;
		}		
		protected function onSubmitClickHandler( e:MouseEvent = null ):void {			
			var txt:String = _inputText.text;
			if ( txt.length != 0 ) {
				var obj:Object = new Object();
				obj.txt = txt;
				obj.peerID = _p2p.nearID;
				obj.name = _label.text;
				_p2p.post( obj );
				appendOutput( "[Me]:" + txt );
				_inputText.text = "";
			}
		}
		
		private function onP2PStatus( e:PeerEvent ):void {
			trace( "onP2PStatusHandler:" + e.type );
			var i:int;			
			var dataP:IDataProvider = _userList.dataProvider;
			var len:uint = dataP.length;
			
			switch ( e.type ) {
				// P2P 連接成功時
				case PeerEvent.NET_CONNECTION_CONNECT_SUCCESS: 
					var d:Date = new Date();
					_label.text = "Name_" + d.getSeconds() + int( Math.random() * 999 );					
					break;
				// P2P Group 連接成功時
				case PeerEvent.NET_GROUP_CONNECT_SUCCESS: 
					
					CONFIG::air{
					if (progressPopup) {
						progressPopup.hide();						
					}
					Toast.show( "Connected Success", 3000 );
					}
					_submitBtn.enabled = true;					
					//onSubmitClickHandler( null );						
					
					break;
				// 新的使用者加入時
				case PeerEvent.NET_GROUP_NEIGHBOR_CONNECT: 
					var o:Object = new Object();
					o.label = e.message.peerID;
					o.id = e.message.peerID;
					dataP.addItem( o );					
					break;			
				// 有的使用者離開時
				case PeerEvent.NET_GROUP_NEIGHBOR_DISCONNECT: 
					for ( i = 0; i < len; i++ ) {
						if ( dataP.getItemAt( i ).id == e.message.peerID ) {
							dataP.removeItemAt( i );
							break;
						}
					}
					break;
				// 接收到群組的訊息時
				case PeerEvent.NET_GROUP_POSTING_NOTIFY: 
					for ( i = 0; i < len; i++ ) {
						var obj:Object = dataP.getItemAt( i );
						if ( obj.id == e.message.peerID ) {
							obj.label = e.message.name;
							dataP.updateItem( obj, obj );
							break;
						}
					}
					appendOutput( "[" + e.message.name + "]:" + e.message.txt );
					break;
			}
		}
		
		protected function appendOutput( txt:String ):void {
			_outputText.text += txt + "\n";
		}
		
			
		private function onRemovedFromStageHandler(e:Event):void {
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE , onTimerCompleteHandler);
			_timer = null;
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN , onKeyDownHandler);
			_submitBtn.removeEventListener( MouseEvent.CLICK, onSubmitClickHandler );
			_submitBtn =  null;
			_p2p.removeEventListener( PeerEvent.NET_CONNECTION_CONNECT_SUCCESS, onP2PStatus );
			_p2p.removeEventListener( PeerEvent.NET_GROUP_CONNECT_SUCCESS, onP2PStatus );
			_p2p.removeEventListener( PeerEvent.NET_GROUP_NEIGHBOR_CONNECT, onP2PStatus );
			_p2p.removeEventListener( PeerEvent.NET_GROUP_NEIGHBOR_DISCONNECT, onP2PStatus );
			_p2p.removeEventListener( PeerEvent.NET_GROUP_POSTING_NOTIFY, onP2PStatus );
			_p2p.destroy();
			_p2p = null;
			CONFIG::air{
				try {					
					progressPopup.dispose();
					progressPopup = null;				
				}catch (err:Error) {				
				}
			}
		}
		
	
		
	
	
	} //__________________________________________________________________________________ End Class
} //__________________________________________________________________________________ End Package