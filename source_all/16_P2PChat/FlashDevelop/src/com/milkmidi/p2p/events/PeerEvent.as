package com.milkmidi.p2p.events {
	import flash.events.Event;

	public class PeerEvent extends Event {
		
		// NetConnection 連線成功時
		public static const NET_CONNECTION_CONNECT_SUCCESS	:String = "NetConnection.Connect.Success";
		// NetGroup 群組連線成功
		public static const NET_GROUP_CONNECT_SUCCESS		:String = "NetGroup.Connect.Success";		
		// NetGroup 群組發送訊息
		public static const NET_GROUP_POSTING_NOTIFY		:String = "NetGroup.Posting.Notify";		
		// 新使用者加入時		 
		public static const NET_GROUP_NEIGHBOR_CONNECT		:String = "NetGroup.Neighbor.Connect";				
		// 使用者離開時		 
		public static const NET_GROUP_NEIGHBOR_DISCONNECT	:String = "NetGroup.Neighbor.Disconnect";
		
		// 發送的訊息
		private var _message:Object;
		public function get message():Object { return _message; }		
		
		public function PeerEvent(type:String, pMessage:Object = null) {						
			super(type, false, false);
			this._message = pMessage;
		}
		override public function clone():Event {
			return new PeerEvent(type , _message);			
		}
		override public function toString():String {
			return this.formatToString( "PeerEvent" , "type" , "message");
		}
		
		

	}
}