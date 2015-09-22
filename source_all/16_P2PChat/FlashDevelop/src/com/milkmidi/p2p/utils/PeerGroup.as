/**
 * @author milkmidi
 * @see http://milkmidi.blogspot.com
 */
package com.milkmidi.p2p.utils {		
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	import flash.net.NetStream;
	import flash.events.Event;
	import com.milkmidi.p2p.events.PeerEvent;

	[Event(name = "NetGroup.Posting.Notify", type = "com.milkmidi.p2p.events.PeerEvent")]
	[Event(name = "NetConnection.Connect.Success", type = "com.milkmidi.p2p.events.PeerEvent")]
	[Event(name = "NetGroup.Connect.Success", type = "com.milkmidi.p2p.events.PeerEvent")]
	[Event(name = "NetStream.Connect.Success", type = "com.milkmidi.p2p.events.PeerEvent")]
	[Event(name = "NetGroup.Posting.Notify", type = "com.milkmidi.p2p.events.PeerEvent")]
	[Event(name = "NetGroup.Neighbor.Connect", type = "com.milkmidi.p2p.events.PeerEvent")]
	[Event(name = "NetGroup.Neighbor.Disconnect", type = "com.milkmidi.p2p.events.PeerEvent")]
	
	public class PeerGroup extends EventDispatcher   {	
		// 同一區網內, 分組用的示別名稱
		private var _groupName	:String;
		public function get groupName():String {	return _groupName;		}
		
		private var _nc			:NetConnection;		
		public function get netConnection():NetConnection {	return this._nc;	}
		
		private var _group		:NetGroup;
		
		// 指定目前玩家的名字
		private var _name			:String = "[P2P]";		
		public function get name():String { return _name; }		
		public function set name(value:String):void {	_name = value;		}		
		
		// 連線後, 得到唯一的視別碼
		private var _nearID:String;
		public function get nearID():String {	return this._nearID;		}
		
		// 區網連線
		public static const LOCAL_P2P:String = "rtmfp:";
		
		// 要連接的通訊網址
		private var _connectURL:String;
		//__________________________________________________________________________________ Constructor
		public function PeerGroup(pConnectURL:String , pGroupName:String)  {			
			this._connectURL = pConnectURL;
			this._groupName = pGroupName;
			this._nc = new NetConnection();
			this._nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusHandler);
			this._nc.connect( _connectURL );
		}		
		// 當 NetConnection 連線時的偵聽函式
		private function onNetStatusHandler(e:NetStatusEvent):void {
			var code:String = e.info.code;
			trace(name, 'netStatusHandler() code:' + code);					
			switch( code ) {
				case "NetConnection.Connect.Success":
					this._nearID = _nc.nearID;
					trace(name, code, "\nnearID:" + this._nearID);		
					dispatchEvent(new PeerEvent(PeerEvent.NET_CONNECTION_CONNECT_SUCCESS));
					onConnect();
					break;													
				case "NetGroup.Connect.Success":
					dispatchEvent(new PeerEvent(PeerEvent.NET_GROUP_CONNECT_SUCCESS, e.info.message ));
					break;				
				case "NetGroup.SendTo.Notify":
				case "NetGroup.Posting.Notify":
					dispatchEvent(new PeerEvent(PeerEvent.NET_GROUP_POSTING_NOTIFY, e.info.message ));					
					break;						
				case "NetGroup.Neighbor.Connect": 
					dispatchEvent(new PeerEvent( PeerEvent.NET_GROUP_NEIGHBOR_CONNECT, e.info ));
					break;
				case "NetGroup.Neighbor.Disconnect":
					dispatchEvent(new PeerEvent( PeerEvent.NET_GROUP_NEIGHBOR_DISCONNECT, e.info ));
					break;			
            }
		}				
		private function onConnect():void {			
			trace( name, "onConnect" );			
            var groupSpec:GroupSpecifier = new GroupSpecifier( _groupName );			
			// 啟用發送, 才能使用 group.post 
            groupSpec.postingEnabled = true;							
			groupSpec.routingEnabled = true;			
            groupSpec.ipMulticastMemberUpdatesEnabled = true;			
            groupSpec.serverChannelEnabled = true;    
            groupSpec.multicastEnabled = true;
			if ( _connectURL == LOCAL_P2P) {				
				groupSpec.addIPMulticastAddress("225.225.0.1:30000");		
				trace(name, "setupGroup:LOCAL_P2P");				
			}			   			
			// 得到 Group 視別字串
			var groupspecAuthor:String = groupSpec.groupspecWithAuthorizations();			
            _group = new NetGroup(_nc, groupspecAuthor);							
            _group.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusHandler);      
			trace( name, "Join:"  + groupspecAuthor);				
			dispatchEvent(new PeerEvent(PeerEvent.NET_GROUP_CONNECT_SUCCESS, groupspecAuthor));			
		}		
		
		public function post(pMessage:Object):String {					
			trace( name, "post > :\n" + echoObject(pMessage) );						
			pMessage.sender = _nearID;		
			
			//try {
				return _group.post( pMessage );				
			//}catch (err:Error){
			
			//}
			//return "";
		}		
		public function sendToNearest( pMessage:Object , pPeerID:String):String {
			trace( name, "sendToNearest > :\n" + echoObject(pMessage) );
			var address:String = _group.convertPeerIDToGroupAddress( pPeerID );			
			return _group.sendToNearest( pMessage , address );
		}
		
		private static function echoObject( pObj:Object ):String {
			var str:String = ""
			for (var a:String in pObj) {
				str += a + "=" + pObj[a] + "\n";
			}
			return str;
		}
		
		// 得到目前同群組下有多少位使用者
		public function get neighborCount():int {
			if (_group)
				return _group.neighborCount;
			else
				return 0;
		}
		
		// 關閉所有連線
		public function destroy():void {
			try {				
				_nc.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatusHandler);
				_nc.close();		
				_nc = null;			
				
				_group.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatusHandler);              				
				_group = null;
			}catch (err:Error){
			
			}
			
		}
	
	}//__________________________________________________________________________________ End Class
}//__________________________________________________________________________________ End Package